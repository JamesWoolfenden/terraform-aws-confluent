data "aws_ami" "broker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["confluent-broker-${var.confluent_broker_version}*"]
  }

  owners = [var.source_ami_account_id]
}
