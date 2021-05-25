variable "account_name" {
  type = string
}

variable "allowed_ranges" {
  type = list(any)
}

variable "allowed_connect_cluster_range" {
  type = list(any)
}

variable "bastion_count" {
  type = string
}

variable "broker_protocol" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "confluent_broker_version" {
  type = string
}

variable "confluent_connect_version" {
  type = string
}

variable "confluent_control_version" {
  type = string
}

variable "confluent_license" {
  type    = string
  default = "123456789"
}

variable "confluent_schema_version" {
  type = string
}

variable "confluent_zookeeper_version" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "domain" {
  type = string
}

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
