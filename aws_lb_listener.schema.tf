resource "aws_lb_listener" "schema" {
  load_balancer_arn = aws_lb.schema.arn
  port              = "6668"
  protocol          = "HTTPS"

  default_action {
    target_group_arn = aws_lb_target_group.schema.arn
    type             = "forward"
  }
}
