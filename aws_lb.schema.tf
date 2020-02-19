resource "aws_lb" "schema" {
  internal                   = true
  load_balancer_type         = "network"
  subnets                    = [data.aws_subnet_ids.subnets.ids]
  enable_deletion_protection = false

  depends_on = [aws_instance.control-center]

  tags = var.common_tags
}
