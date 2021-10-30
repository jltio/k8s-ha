# Cluster k8s HA

Depuis le projet initial [k3s-ha-etcd](https://github.com/jltio/k3s-ha-etcd)

## Description du projet

**Remarque:** Ce projet est un POC. Le code et l'implémentation sont améliorables.

En se basant sur les projets et documentations:

* [K3S Ansible](https://github.com/k3s-io/k3s-ansible)
* [Kubespray](https://github.com/kubernetes-sigs/kubespray)
* [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)
* [Exemple Haproxy](https://gitlab.com/xavki/presentations-kubernetes/-/tree/master/37-kubspray-haproxy)
* [Installation Traefik](https://blog.wescale.fr/2020/03/06/traefik-2-reverse-proxy-dans-kubernetes/)

L'objectif est de créer un cluster haute disponibilité Kubernetes.

Dans ce code, 8 serveurs sont utilisés avec les caratéristiques suivantes:

* CentOS 7
* 1 CPU par serveur
* 1G de RAM par serveur

3 serveurs seront utilisés pour

* La base de données etcd 3.x en cluster et haute disponibilité + connexions client/serveur/peer en TLS.
* Le Controle Plane Kubernetes k8s se connectant au cluster etcd.
* Les instances de master k8s ne seront pas visibles dans la liste des nodes.

3 serveurs seront utilisés pour

* Node k8s utilisant Docker
* Installation de kubelet, kube-proxy et flannel

2 serveurs seront utilisés pour

* Haproxy qui va loadbalancer en TCP les nodes master
* Haproxy va aussi loadbalancer en TCP d'ingress controler Traefik
* Keepalived pour maintenir une IP virtuelle
* 1 serveur actif, 1 serveur passif

Après installation du cluster, les POD disponibles seront:

* Flannel
* CoreDNS
* Traefik

![Schema](docs/schema-cluster-k8s.png)

## Provisionner les serveurs avec Vagrant

Pour faire des tests sur un poste de travail, ce projet inclut un fichier `Vagranfile` pour VirtualBox pour créer les 8 serveurs. Le fichier `inventory/inventory.ini.sample` est cohérent avec la description du fichier `Vagranfile`.

L'image CentOS 7 utilisée par Vagrant est [ici](https://app.vagrantup.com/centos/boxes/7)

Création des serveurs

```bash
vagrant up
```

Suppression des serveurs

```bash
vagrant destroy -f
```

## Lancement des Playbooks Ansible

Ce projet fonctionne sur **Ansible version 2.9**

Avant de lancer, se connecter sur les 8 serveurs via SSH avec une clé SSH ne demandant pas de mot de passe (sans passphrase ou ssh-agent)

Fonctionne uniquement sur **CentOS 7**

Pour installer Ansible utiliser le script `contrib/install-ansible.sh`.

### Préparation de l'inventaire

Copier le fichier `inventory/inventory.ini.sample` en `inventory/inventory.ini`. Adapter le fichier `inventory/inventory.ini` si nécessaire pour y mettre les bonnes adresse IP. Changer aussi le fichier `variables.yml` pour mettre l'adresse IP virtuelle d'Haproxy. Si vous avez utilisez `Vagranfile`, pas besoin de changer le fichier `inventory/inventory.ini`.

Tester la connexion sur tout les serveurs avec Ansible

```bash
ansible-playbook 99-test-connection.yml
```

Lancer le premier playbook

```bash
ansible-playbook 00-prereq.yml
```

Puis reboot des serveurs pour appliquer les changements SELinux

Installer etcd

```bash
ansible-playbook 01-etcd.yml
```

Installer les nodes master k8s

```bash
ansible-playbook 02-k8s-masters.yml
```

Installer Haproxy et Keepalived

```bash
ansible-playbook 03-haproxy.yml
```

Installer les nodes worker k8s

```bash
ansible-playbook 04-k8s-workers.yml
```

Si on souhaite tout supprimer pour repartir de zéro

```bash
ansible-playbook 99-delete-datas.yml
```
