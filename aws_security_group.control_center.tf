resource "aws_security_group" "control-center" {
  name = "CONTROL-CENTER"

  description = "control-center security group - Managed by Terraform"
  vpc_id      = var.vpc_id

  # web ui
  ingress {
    from_port   = 9021
    to_port     = 9021
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

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = var.egress_range
  }


}
