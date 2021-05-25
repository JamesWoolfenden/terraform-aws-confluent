data "aws_ami" "redhat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-BASE-*"]
  }

  owners = [local.source_ami_account_id]
}
