allowed_ips                   = ["10.01.01.01"]
account_name                  = "test"
bastion_count                 = 1
broker_protocol               = "SSL"
cluster_name                  = "mycluster"
confluent_broker_version      = "v1"
confluent_connect_version     = "v1"
confluent_control_version     = "v1"
confluent_schema_version      = "v1"
confluent_zookeeper_version   = "v1"
allowed_connect_cluster_range = "0.0.0.0/0"
dns_zone                      = "domain.com"
domain                        = "example.com"
environment                   = "D"

common_tags = {
  Application = "Confluent"
  Environment = "Dev"
}
