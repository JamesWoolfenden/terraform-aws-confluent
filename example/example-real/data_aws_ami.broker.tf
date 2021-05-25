data "aws_ami" "broker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["confluent-broker-${var.confluent_broker_version}*"]
  }

  owners = [local.source_ami_account_id]
}

locals {
  source_ami_account_id = data.aws_caller_identity.current.account_id
}
