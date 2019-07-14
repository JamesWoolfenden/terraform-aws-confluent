resource "aws_security_group" "schema" {
  name        = "${var.environment}-SCHEMA-SG"
  description = "schema - Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id

  # allow clients from anywhere - temporary for follower cluster in frankfurt - should get their submet range from terraform
  # 9092-9095 for all broker protocols
  ingress {
    from_port   = 9092
    to_port     = 9096
    protocol    = "TCP"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # from bastion
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = ["${aws_security_group.bastions.id}"]
  }

  # Allow ping from my ip, self, bastion
  ingress {
    from_port       = 8
    to_port         = 0
    protocol        = "icmp"
    self            = true
    security_groups = ["${aws_security_group.bastions.id}"]
    cidr_blocks     = ["${var.allowed_ips}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.common_tags,
  map("Name", "${var.environment}-SCHEMA-SG"))}"
}
