resource "aws_route53_zone" "reverse" {
  name       = "10.in-addr.arpa"
  comment    = "Reverse DNS Lookup for Confluent - Managed by Terraform"
  vpc_id     = data.aws_vpc.confluent.vpc_id
  vpc_region = var.vpc_region
}
