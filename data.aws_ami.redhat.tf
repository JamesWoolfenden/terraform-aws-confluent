data "aws_ami" "redhat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-BASE-*"]
  }

  owners = [var.source_ami_account_id]
}
