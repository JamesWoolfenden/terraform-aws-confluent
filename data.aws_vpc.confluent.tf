data "aws_vpc" "confluent" {
  cidr_block = var.vpc_cidr
}
