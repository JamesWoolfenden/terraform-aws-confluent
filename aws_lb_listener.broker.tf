resource "aws_lb_listener" "broker" {
  load_balancer_arn = aws_lb.broker.arn
  port              = "6668"
  protocol          = "HTTPS"

  default_action {
    target_group_arn = aws_lb_target_group.broker.arn
    type             = "forward"
  }
}
