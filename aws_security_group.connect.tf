resource "aws_security_group" "connect" {
  name        = "CONNECT"
  description = "Connect security group - Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Broker protocol"
    from_port       = 8083
    to_port         = 8083
    protocol        = "TCP"
    self            = true
    security_groups = [aws_security_group.control-center.id]
  }

  ingress {
    description     = "SSH In"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = [aws_security_group.bastions.id]
  }

  egress {
    description = "Allow outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = var.egress_range
  }


}
