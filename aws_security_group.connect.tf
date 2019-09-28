resource "aws_security_group" "connect" {
  name        = "${var.environment}-CONNECT-SG"
  description = "Connect security group - Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id

  # connect http interface - only accessable on host, without this
  # control-center needs access
  ingress {
    from_port       = 8083
    to_port         = 8083
    protocol        = "TCP"
    self            = true
    security_groups = ["${aws_security_group.control-center.id}"]
  }

  # from bastion
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = ["${aws_security_group.bastions.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.common_tags,
  map("Name", "${var.environment}-CONNECT-SG"))}"
}
