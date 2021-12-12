resource "aws_security_group" "zookeepers" {
  name        = "ZOOKEEPER"
  description = "Zookeeper security group - Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow other Zookeepers"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description     = "Allow 2181"
    from_port       = 2181
    to_port         = 2181
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  ingress {
    description     = "Allow 5570"
    from_port       = 5570
    to_port         = 5570
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  ingress {
    description     = "Allow 5580"
    from_port       = 5580
    to_port         = 5580
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  ingress {
    description     = "Allow 5590"
    from_port       = 5590
    to_port         = 5590
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  # from bastion
  ingress {
    description     = "Allow SSH from Bastion"
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
