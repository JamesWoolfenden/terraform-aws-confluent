#!/usr/bin/env bash

hostnamectl set-hostname controlcentre.${private_dns_zone}

echo "
bootstrap.servers=${broker_private_ip_0}:9092,${broker_private_ip_1}:9092,${broker_private_ip_2}:9092
confluent.license=${confluent_license}

" >> /etc/confluent-control-center/control-center-production.properties

sed -i 's/Restart=yes/Restart=always/g' /usr/lib/systemd/system/confluent-control-center.service

mkdir -p /var/ssl/private
aws s3 --region eu-west-2 cp s3://certificates-${aws_id}/confluent.control-center/$(hostname) /var/ssl/private --recursive
chown -R cp-control-center:confluent /var/ssl/private/*

mkdir -p /etc/security/keytabs
aws s3 --region eu-west-2 cp s3://kerberos-${aws_id}/controlcentre.${account_name}.keytab /etc/security/keytabs/controlcentre.service.keytab
chown cp-kafka:confluent /etc/security/keytabs/controlcentre.service.keytab

systemctl stop firewalld
systemctl daemon-reload
systemctl restart confluent-control-center
