data "aws_route53_zone" "selected" {
  zone_id = var.private_zone_id
}
