resource "aws_route53_record" "zookeeper" {
  # checkov:skip=CKV2_AWS_23: A record points to private IP of EC2 instance, not an AWS alias resource
  count   = length(var.zk_private_ip)
  zone_id = var.private_zone.zone_id
  name    = "zkserver${count.index + 1}"
  type    = "A"
  ttl     = "60"
  records = [element(var.zk_private_ip, count.index)]
}
resource "aws_route53_record" "reverse_zookeeper" {
  count   = length(var.zk_private_ip)
  zone_id = aws_route53_zone.reverse.id
  name    = "${element(split(".", element(var.zk_private_ip, count.index)), 3)}.${element(split(".", element(var.zk_private_ip, count.index)), 2)}.${element(split(".", element(var.zk_private_ip, count.index)), 1)}"
  type    = "PTR"
  ttl     = "300"
  records = [element(aws_route53_record.zookeeper.*.fqdn, count.index)]
}
