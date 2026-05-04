resource "aws_route53_record" "kafka" {
  # checkov:skip=CKV2_AWS_23: A record points to private IP of EC2 instance, not an AWS alias resource
  count   = length(var.broker_private_ip)
  zone_id = var.private_zone.zone_id
  name    = "broker${count.index + 1}"
  type    = "A"
  ttl     = "60"
  records = [element(var.broker_private_ip, count.index)]
}
resource "aws_route53_record" "reverse_kafka" {
  count   = length(var.broker_private_ip)
  zone_id = aws_route53_zone.reverse.id
  name    = "${element(split(".", element(var.broker_private_ip, count.index)), 3)}.${element(split(".", element(var.broker_private_ip, count.index)), 2)}.${element(split(".", element(var.broker_private_ip, count.index)), 1)}"
  type    = "PTR"
  ttl     = "300"
  records = [element(aws_route53_record.kafka.*.fqdn, count.index)]
}
