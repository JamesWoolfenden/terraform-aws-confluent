data "aws_ami" "connect" {
  most_recent = true

  filter {
    name   = "name"
    values = ["confluent-connect-${var.confluent_connect_version}*"]
  }

  owners = [var.source_ami_account_id]
}
