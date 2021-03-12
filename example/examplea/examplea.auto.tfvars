allowed_ranges                = ["10.01.01.01/32"]
allowed_connect_cluster_range = ["10.0.0.0/16"]
account_name                  = "test"
bastion_count                 = 1
broker_protocol               = "SSL"
cluster_name                  = "mycluster"
confluent_broker_version      = "v1"
confluent_connect_version     = "v1"
confluent_control_version     = "v1"
confluent_schema_version      = "v1"
confluent_zookeeper_version   = "v1"
dns_zone                      = "domain.com"
domain                        = "example.com"

common_tags = {
  name        = "examplea"
  "createdby" = "Terraform"
  module      = "terraform-aws-confluent"
}
