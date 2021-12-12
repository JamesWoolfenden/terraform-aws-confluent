resource "aws_security_group" "brokers" {
  name        = "BROKER"
  description = "brokers - Managed by Terraform"
  vpc_id      = var.vpc_id

  # 9092-9095 for all broker protocols
  ingress {
    description = "9092-9095 for all broker protocols"
    from_port   = 9092
    to_port     = 9096
    protocol    = "TCP"
    cidr_blocks = var.allowed_ranges
  }

  # interbroker communication
  # 6668 for all broker protocols
  ingress {
    description     = "interbroker communication"
    from_port       = 6668
    to_port         = 6668
    protocol        = "TCP"
    self            = true
    security_groups = [aws_security_group.connect.id]
    cidr_blocks     = var.allowed_connect_cluster_range
  }

  # Allow ping from my ip, self, bastion
  ingress {
    description     = "ping"
    from_port       = 8
    to_port         = 0
    protocol        = "icmp"
    self            = true
    security_groups = [aws_security_group.bastions.id]
    cidr_blocks     = var.allowed_ranges
  }

  # from bastion
  ingress {
    description     = "Allow SSH"
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
