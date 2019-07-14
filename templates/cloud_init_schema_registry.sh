#!/usr/bin/env bash

hostnamectl set-hostname schema${count}.${private_dns_zone}
echo "
kafkastore.bootstrap.servers=${broker_protocol}://${broker_private_ip_0}:9092,${broker_protocol}://${broker_private_ip_1}:9092,${broker_protocol}://${broker_private_ip_2}:9092

" >> /etc/schema-registry/schema-registry.properties

sed -i 's/Restart=yes/Restart=always/g' /usr/lib/systemd/system/confluent-schema-registry.service

mkdir -p /var/ssl/private
aws s3 --region eu-west-2 cp s3://certificates-${aws_id}/confluent.schema-registry/$(hostname) /var/ssl/private --recursive
chown -R cp-schema-registry:confluent /var/ssl/private/*

mkdir -p /etc/security/keytabs
aws s3 --region eu-west-2 cp s3://kerberos-${aws_id}/schema${count}.${account_name}.keytab /etc/security/keytabs/schema.service.keytab

chown cp-schema-registry:confluent /etc/security/keytabs/schema.service.keytab

sed -i "s/REPLACEMEWITHSED/$$(hostname)/g" /etc/kafka/schema_jaas.conf
sed -i "s/REPLACEMEWITHSED/$$(hostname)/g" /etc/krb5.conf

systemctl stop firewalld
systemctl daemon-reload
systemctl restart confluent-schema-registry
