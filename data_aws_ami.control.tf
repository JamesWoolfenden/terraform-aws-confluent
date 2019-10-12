data "aws_ami" "control" {
  most_recent = true

  filter {
    name   = "name"
    values = ["confluent-control-center-${var.confluent_control_version}*"]
  }

  owners = [var.source_ami_account_id]
}
