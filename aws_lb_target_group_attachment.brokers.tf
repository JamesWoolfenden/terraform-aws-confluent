resource "aws_lb_target_group_attachment" "brokers" {
  count            = length(var.broker_subnets)
  target_group_arn = aws_lb_target_group.broker.arn
  target_id        = element(aws_instance.brokers.*.id, count.index)
  port             = 6668
}
