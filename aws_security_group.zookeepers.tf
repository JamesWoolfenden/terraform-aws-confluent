resource "aws_security_group" "zookeepers" {
  name        = "ZOOKEEPER"
  description = "Zookeeper security group - Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  ingress {
    from_port       = 5570
    to_port         = 5570
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  ingress {
    from_port       = 5580
    to_port         = 5580
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
  }

  ingress {
    from_port       = 5590
    to_port         = 5590
    protocol        = "TCP"
    security_groups = [aws_security_group.brokers.id, aws_security_group.connect.id]
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

  tags = var.common_tags
}
