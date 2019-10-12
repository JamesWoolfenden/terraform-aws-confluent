data "aws_ami" "schema" {
  most_recent = true

  filter {
    name   = "name"
    values = ["confluent-schema-${var.confluent_schema_version}*"]
  }

  owners = [var.source_ami_account_id]
}
