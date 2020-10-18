resource "aws_route53_zone" "reverse" {
  name    = "10.in-addr.arpa"
  comment = "Reverse DNS Lookup for Confluent - Managed by Terraform"

  vpc {
    vpc_id     = data.aws_vpc.confluent.id
    vpc_region = data.aws_region.current.name
  }
  tags = var.common_tags

}

data "aws_region" "current" {}
