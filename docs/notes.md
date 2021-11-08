# Notes

## Vagrant

Sur les VM créées il y a 2 interfaces réseau.

* eth0: interface utilisée pour Vagrant
* eth1: interface utilisée pour Kubernetes

## prereq

RAS

## etcd

RAS

## Kubernetes master

kubectl get cs

## Haproxy

RAS, VIP OK

## Kubernetes nodes

- N'utilise pas la VIP Haproxy
- Problème avec IPvS -> ne fonctionne pas -> retourne en mode iptables