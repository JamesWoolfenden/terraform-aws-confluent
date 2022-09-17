resource "aws_route53_zone" "reverse" {
  #checkov:skip=CKV2_AWS_39
  name    = "10.in-addr.arpa"
  comment = "Reverse DNS Lookup for Confluent - Managed by Terraform"

  vpc {
    vpc_id     = var.vpc_id
    vpc_region = data.aws_region.current.name
  }


}

data "aws_region" "current" {}


resource "aws_route53_key_signing_key" "example" {
  hosted_zone_id             = aws_route53_zone.reverse.id
  key_management_service_arn = var.kms_key.arn
  name                       = "example"
}

resource "aws_route53_hosted_zone_dnssec" "example" {
  depends_on = [
    aws_route53_key_signing_key.example
  ]
  hosted_zone_id = aws_route53_key_signing_key.example.hosted_zone_id
}
