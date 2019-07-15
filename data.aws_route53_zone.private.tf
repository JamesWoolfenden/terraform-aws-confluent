data "aws_route53_zone" "private" {
    domain       = var.domain
    private_zone = true
}
