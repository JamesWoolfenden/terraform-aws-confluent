resource "aws_security_group" "ssh" {
  name        = "SSH"
  description = "Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id

  # Allow ping from my ip and self
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    self        = true
    cidr_blocks = var.allowed_ranges
  }

  # from bastion
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.bastions.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}
