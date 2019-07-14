resource "aws_security_group" "control-center" {
  name = "${var.environment}-CONTROL-CENTER-SG"

  description = "control-center security group - Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id

  # web ui
  ingress {
    from_port   = 9021
    to_port     = 9021
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.common_tags,
  map("Name", "${var.environment}-CONTROL-CENTER-SG"))}"
}
