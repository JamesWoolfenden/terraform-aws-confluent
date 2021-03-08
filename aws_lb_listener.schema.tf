resource "aws_lb_listener" "schema" {
  load_balancer_arn = aws_lb.schema.arn
  port              = "6668"
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"

  default_action {
    target_group_arn = aws_lb_target_group.schema.arn
    type             = "forward"
  }
}
