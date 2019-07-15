variable "account_name" {}

variable "allowed_ips" {}

variable "bastion_count" {}

variable "broker_protocol" {}

variable "cluster_name" {}

variable "confluent_broker_version" {}

variable "confluent_connect_version" {}

variable "confluent_control_version" {}

variable "confluent_license" {}

variable "confluent_schema_version" {}

variable "confluent_zookeeper_version" {}

variable "dns_zone" {}

variable "environment" {}

locals {
  bastion_private_ip        = cidrhost(data.aws_subnet.public.0.cidr_block, 10)
  broker_private_ip         = [cidrhost(data.aws_subnet.private.0.cidr_block, 11), cidrhost(data.aws_subnet.private.1.cidr_block, 11), cidrhost(data.aws_subnet.private.2.cidr_block, 11)]
  connect_private_ip        = [cidrhost(data.aws_subnet.private.0.cidr_block, 12), cidrhost(data.aws_subnet.private.1.cidr_block, 12), cidrhost(data.aws_subnet.private.2.cidr_block, 12)]
  control_center_private_ip = [cidrhost(data.aws_subnet.private.0.cidr_block, 13)]
  schema_private_ip         = [cidrhost(data.aws_subnet.private.0.cidr_block, 14), cidrhost(data.aws_subnet.private.1.cidr_block, 14), cidrhost(data.aws_subnet.private.2.cidr_block, 14)]
  zk_private_ip             = [cidrhost(data.aws_subnet.private.0.cidr_block, 15), cidrhost(data.aws_subnet.private.1.cidr_block, 15), cidrhost(data.aws_subnet.private.1.cidr_block, 16), cidrhost(data.aws_subnet.private.2.cidr_block, 15), cidrhost(data.aws_subnet.private.2.cidr_block, 16)]
  key_name                  = "id_rsa.${var.account_name}"
  private_dns_zone          = "${var.account_name}.${var.dns_zone}"
}

variable "common_tags" {
  type = map
}
