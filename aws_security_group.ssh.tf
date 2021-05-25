resource "aws_security_group" "ssh" {
  name        = "SSH"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

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
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = var.egress_range
  }


}
