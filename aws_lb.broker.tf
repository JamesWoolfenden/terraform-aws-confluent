resource "aws_lb" "broker" {
  enable_deletion_protection = false
  internal                   = true
  load_balancer_type         = "network"
  subnets                    = [data.aws_subnet_ids.subnets.id]

  depends_on = [aws_instance.brokers]

  tags = var.common_tags
}
