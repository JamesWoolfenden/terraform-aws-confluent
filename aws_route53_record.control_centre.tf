resource "aws_route53_record" "control_centre" {
  count   = "${length(var.control_center_private_ip)}"
  zone_id = "${var.private_zone_id}"
  name    = "controlcentre"
  type    = "A"
  ttl     = "60"
  records = ["${element(var.control_center_private_ip, count.index)}"]
}

resource "aws_route53_record" "reverse_control_centre" {
  count   = "${length(var.control_center_private_ip)}"
  zone_id = "${aws_route53_zone.reverse.id}"
  name    = "${element(split(".", element(var.control_center_private_ip, count.index)), 3)}.${element(split(".", element(var.control_center_private_ip, count.index)), 2)}.${element(split(".", element(var.control_center_private_ip, count.index)), 1)}"
  type    = "PTR"
  ttl     = "300"
  records = ["${element(aws_route53_record.control_centre.*.fqdn, count.index)}"]
}
