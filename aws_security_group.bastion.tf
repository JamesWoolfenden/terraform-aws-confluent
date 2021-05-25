resource "aws_security_group" "bastions" {
  name        = "BASTION"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  # Allow ping from my ip
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.allowed_ranges
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    self        = true
    cidr_blocks = var.allowed_ranges
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = var.egress_range
  }


}
