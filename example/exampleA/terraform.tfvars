allowed_ips                  = "10.01.01.01"
account_name                 = "test"
bastion_count                = 1
broker_protocol              = "SSL"
cluster_name                 = "mycluster"
confluent_broker_version     = "v1"
confluent_connect_version    = "v1"
confluent_control_version    = "v1"
confluent_schema_version     = "v1"
confluent_zookeeper_version  = "v1"
dns_zone                     = "domain.com"
environment                  = "D"

common_tags = {
  Application = "Confluent"
  Environment = "Dev"
  CostCode    = "0"
  SquadName   = "jim"
  AccountType = "Confluent"
  Alarms      = "true"
}
