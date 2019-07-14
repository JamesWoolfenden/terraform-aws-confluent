#!/usr/bin/env bash

hostnamectl set-hostname connectcluster${count}.${private_dns_zone}

echo "
# A list of host/port pairs to use for establishing the initial connection to the Kafka cluster.
bootstrap.servers=broker1.${private_dns_zone}:6668,broker2.${private_dns_zone}:6668,broker3.${private_dns_zone}:6668
# unique name for the cluster, used in forming the Connect cluster group. Note that this must not conflict with consumer group IDs
group.id=${account_name}-${aws_id}
confluent.license=${confluent_license}

" >> /etc/kafka/connect-distributed.properties

mkdir -p /var/ssl/private
aws s3 --region eu-west-2 cp s3://certificates-${aws_id}/confluent.connect-cluster/$(hostname) /var/ssl/private --recursive
chown -R cp-kafka-connect-connect:confluent /var/ssl/private/*


mkdir -p /etc/security/keytabs
aws s3 --region eu-west-2 cp s3://kerberos-${aws_id}/connectcluster${count}.${account_name}.keytab /etc/security/keytabs/connect.service.keytab
chown cp-kafka-connect:confluent /etc/security/keytabs/connect.service.keytab


sed -i "s/REPLACEMEWITHSED/connectcluster${count}.${private_dns_zone}/g" /etc/kafka/connect_jaas.conf
sed -i "s/REPLACEMEWITHSED/connectcluster${count}.${private_dns_zone}/g" /etc/kafka/connect-distributed.properties

systemctl stop firewalld
systemctl daemon-reload
systemctl restart connect

