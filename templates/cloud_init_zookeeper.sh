#!/usr/bin/env bash

hostnamectl set-hostname zkserver${number}.${private_dns_zone}

echo ${count} > /var/lib/zookeeper/myid

echo "
initLimit=5
syncLimit=2
server.0=127.0.0.1:5581:5591
server.1=127.0.0.1:5582:5592
server.2=127.0.0.1:5583:5593
server.3=127.0.0.1:5584:5594
server.4=127.0.0.1:5585:5595

" >> /etc/kafka/zookeeper.properties

chown -R cp-kafka:confluent /var/lib/zookeeper/myid
chown -R cp-kafka:confluent /etc/kafka/*.properties

mkdir -p /etc/security/keytabs
aws s3 --region eu-west-2 cp s3://kerberos-${aws_id}/zkserver${number}.${account_name}.keytab /etc/security/keytabs/zookeeper.service.keytab

chown cp-kafka:confluent /etc/security/keytabs/zookeeper.service.keytab



sed -i "s/REPLACEMEWITHSED/zkserver${number}.${private_dns_zone}/g" /etc/kafka/zookeeper_jaas.conf

sed -i "s/server.${count}.*/server.${count}=127.0.0.1:2888:3888/g" /etc/kafka/zookeeper.properties

echo "
cert = /etc/stunnel/private.pem
pid = /var/run/stunnel.pid

[local-client]
accept = ${zk_private_local_ip}:${zk-client-listener-port}
connect = 127.0.0.1:2181

[local-peer]
accept = ${zk_private_local_ip}:${zk-peer-listener-port}
connect = 127.0.0.1:2888

[local-leader]
accept = ${zk_private_local_ip}:${zk-leader-listener-port}
connect = 127.0.0.1:3888

[zookeeper1-client]
client = yes
accept = 127.0.0.1:5571
connect = ${zk_private_ip_0}:${zk-client-listener-port}

[zookeeper1-peer]
client = yes
accept = 127.0.0.1:5581
connect = ${zk_private_ip_0}:${zk-peer-listener-port}

[zookeeper1-leader]
client = yes
accept = 127.0.0.1:5591
connect = ${zk_private_ip_0}:${zk-leader-listener-port}

[zookeeper2-client]
client = yes
accept = 127.0.0.1:5572
connect = ${zk_private_ip_1}:${zk-client-listener-port}

[zookeeper2-peer]
client = yes
accept = 127.0.0.1:5582
connect = ${zk_private_ip_1}:${zk-peer-listener-port}

[zookeeper2-leader]
client = yes
accept = 127.0.0.1:5592
connect = ${zk_private_ip_1}:${zk-leader-listener-port}

[zookeeper3-client]
client = yes
accept = 127.0.0.1:5573
connect = ${zk_private_ip_2}:${zk-client-listener-port}

[zookeeper3-peer]
client = yes
accept = 127.0.0.1:5583
connect = ${zk_private_ip_2}:${zk-peer-listener-port}

[zookeeper3-leader]
client = yes
accept = 127.0.0.1:5593
connect = ${zk_private_ip_2}:${zk-leader-listener-port}

[zookeeper4-client]
client = yes
accept = 127.0.0.1:5574
connect = ${zk_private_ip_3}:${zk-client-listener-port}

[zookeeper4-peer]
client = yes
accept = 127.0.0.1:5584
connect = ${zk_private_ip_3}:${zk-peer-listener-port}

[zookeeper4-leader]
client = yes
accept = 127.0.0.1:5594
connect = ${zk_private_ip_3}:${zk-leader-listener-port}

[zookeeper5-client]
client = yes
accept = 127.0.0.1:5575
connect = ${zk_private_ip_4}:${zk-client-listener-port}

[zookeeper5-peer]
client = yes
accept = 127.0.0.1:5585
connect = ${zk_private_ip_4}:${zk-peer-listener-port}

[zookeeper5-leader]
client = yes
accept = 127.0.0.1:5595
connect = ${zk_private_ip_4}:${zk-leader-listener-port}
" > /etc/stunnel/stunnel.conf

echo "${stunnel_cert}" > /etc/stunnel/private.pem
chmod 600  /etc/stunnel/private.pem

mkdir -p /var/run/stunnel/
systemctl stop firewalld
systemctl daemon-reload
systemctl restart zookeeper
systemctl start stunnel
