data "aws_ami" "redhat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.*_HVM-*"]
  }

  owners = ["309956199498"]
}

locals {
  source_ami_account_id = data.aws_caller_identity.current.account_id
}
