data "aws_ami" "zookeeper" {
  most_recent = true

  filter {
    name   = "name"
    values = ["confluent-zookeeper-${var.confluent_zookeeper_version}*"]
  }

  owners = [local.source_ami_account_id]
}
