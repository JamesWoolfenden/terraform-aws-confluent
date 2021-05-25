resource "aws_vpc_endpoint_service" "broker" {
  acceptance_required        = true
  network_load_balancer_arns = [aws_lb.broker.arn]
}
