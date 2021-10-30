# etcd

Voir la liste des membres

```bash
export ETCDCTL_API=3
export ENDPOINTS=192.168.100.101:2379,192.168.100.102:2379,192.168.100.103:2379

etcdctl --endpoints=$ENDPOINTS \
        --cacert=/etc/etcd/ca.pem \
        --cert=/etc/etcd/node.pem \
        --key=/etc/etcd/node-key.pem \
        --write-out=table \
        member list
```

Voir le statut des membres

```bash
export ETCDCTL_API=3
export ENDPOINTS=192.168.100.101:2379,192.168.100.102:2379,192.168.100.103:2379

etcdctl --endpoints=$ENDPOINTS \
        --cacert=/etc/etcd/ca.pem \
        --cert=/etc/etcd/node.pem \
        --key=/etc/etcd/node-key.pem \
        --write-out=table \
        endpoint status
```

Voir le temps de réponse des membres

```bash
export ETCDCTL_API=3
export ENDPOINTS=192.168.100.101:2379,192.168.100.102:2379,192.168.100.103:2379

etcdctl --endpoints=$ENDPOINTS \
        --cacert=/etc/etcd/ca.pem \
        --cert=/etc/etcd/node.pem \
        --key=/etc/etcd/node-key.pem \
        --write-out=table \
        endpoint health
```

Faire un backup de la base de données

```bash
export ETCDCTL_API=3
export ENDPOINTS=192.168.100.101:2379

etcdctl --endpoints=$ENDPOINTS \
        --cacert=/etc/etcd/ca.pem \
        --cert=/etc/etcd/node.pem \
        --key=/etc/etcd/node-key.pem \
        --write-out=table \
        snapshot save my.db
```

Voir le status du backup

```bash
export ETCDCTL_API=3
export ENDPOINTS=192.168.100.101:2379

etcdctl --endpoints=$ENDPOINTS \
        --cacert=/etc/etcd/ca.pem \
        --cert=/etc/etcd/node.pem \
        --key=/etc/etcd/node-key.pem \
        --write-out=table \
        snapshot status my.db
```