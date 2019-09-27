#!/usr/bin/env bash

hostnamectl set-hostname broker${count}.${private_dns_zone}

mkfs -t ext4 /dev/nvme1n1
mkfs -t ext4 /dev/nvme2n1
mkfs -t ext4 /dev/nvme3n1

mkdir -p /var/lib/kafka/data1
mkdir -p /var/lib/kafka/data2
mkdir -p /var/lib/kafka/data3

mount /dev/nvme1n1 /var/lib/kafka/data1
mount /dev/nvme2n1 /var/lib/kafka/data2
mount /dev/nvme3n1 /var/lib/kafka/data3

chown cp-kafka:confluent /var/lib/kafka/data1 -Rf
chown cp-kafka:confluent /var/lib/kafka/data2 -Rf
chown cp-kafka:confluent /var/lib/kafka/data3 -Rf

echo /dev/nvme1n1 /var/lib/kafka/data1 ext4 defaults,nofail 0 2 >> /etc/fstab
echo /dev/nvme2n1 /var/lib/kafka/data2 ext4 defaults,nofail 0 2 >> /etc/fstab
echo /dev/nvme3n1 /var/lib/kafka/data3 ext4 defaults,nofail 0 2 >> /etc/fstab

rm -rf /var/lib/kafka/data1/*
rm -rf /var/lib/kafka/data2/*
rm -rf /var/lib/kafka/data3/*

echo "
log.dirs=/var/lib/kafka/data1,/var/lib/kafka/data2,/var/lib/kafka/data3
zookeeper.connect=zkserver1.${private_dns_zone}:2181,zkserver2.${private_dns_zone}:2181,zkserver3.${private_dns_zone}:2181,zkserver4.${private_dns_zone}:2181,zkserver5.${private_dns_zone}:2181
broker.id=${count}

" >> /etc/kafka/server.properties

sed -i 's/Restart=no/Restart=always/g' /usr/lib/systemd/system/kafka.service

mkdir -p /var/ssl/private
aws s3 --region eu-west-2 cp s3://certificates-${aws_id}/confluent.kafka-broker/$(hostname) /var/ssl/private --recursive
chown -R cp-kafka:confluent /var/ssl/private/*


mkdir -p /etc/security/keytabs
aws s3 --region eu-west-2 cp s3://kerberos-${aws_id}/broker${count}.${account_name}.keytab /etc/security/keytabs/kafka.service.keytab
chown cp-kafka:confluent /etc/security/keytabs/kafka.service.keytab

sed -i "s/REPLACEMEWITHSED/broker${count}.${private_dns_zone}/g" /etc/kafka/kafka_server_jaas.conf
sed -i "s/REPLACEMEWITHSED/broker${count}.${private_dns_zone}/g" /etc/kafka/server.properties

systemctl stop firewalld
systemctl daemon-reload
#systemctl restart kafka
