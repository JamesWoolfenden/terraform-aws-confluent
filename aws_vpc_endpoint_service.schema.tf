resource "aws_vpc_endpoint_service" "schema" {
  acceptance_required        = true
  network_load_balancer_arns = [aws_lb.schema.arn]
  tags                       = var.common_tags
}
