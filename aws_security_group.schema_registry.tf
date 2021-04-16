resource "aws_security_group" "schema" {
  name        = "SCHEMA"
  description = "schema - Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id

  # 9092-9095 for all broker protocols
  ingress {
    from_port   = 9092
    to_port     = 9096
    protocol    = "TCP"
    cidr_blocks = [var.vpc_cidr]
  }

  # from bastion
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.bastions.id]
  }

  # Allow ping from my ip, self, bastion
  ingress {
    from_port       = 8
    to_port         = 0
    protocol        = "icmp"
    self            = true
    security_groups = [aws_security_group.bastions.id]
    cidr_blocks     = var.allowed_ranges
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = var.egress_range
  }

  tags = var.common_tags
}
