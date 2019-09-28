resource "aws_security_group" "bastions" {
  name        = "${var.environment}-BASTION"
  description = "Managed by Terraform"
  vpc_id      = data.aws_vpc.confluent.id
  
  # Allow ping from my ip
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["${var.allowed_ips}/32"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    self        = true
    cidr_blocks = ["${var.allowed_ips}/32"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = var.common_tags
}
