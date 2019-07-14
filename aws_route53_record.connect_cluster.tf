resource "aws_route53_record" "connect_cluster" {
  count   = "${length(var.connect_private_ip)}"
  zone_id = "${var.private_zone_id}"
  name    = "connectcluster${count.index + 1}"
  type    = "A"
  ttl     = "60"
  records = ["${element(var.connect_private_ip, count.index)}"]
}

resource "aws_route53_record" "reverse_connect_cluster" {
  count   = "${length(var.connect_private_ip)}"
  zone_id = "${aws_route53_zone.reverse.id}"
  name    = "${element(split(".", element(var.connect_private_ip, count.index)), 3)}.${element(split(".", element(var.connect_private_ip, count.index)), 2)}.${element(split(".", element(var.connect_private_ip, count.index)), 1)}"
  type    = "PTR"
  ttl     = "300"
  records = ["${element(aws_route53_record.connect_cluster.*.fqdn, count.index)}"]
}
