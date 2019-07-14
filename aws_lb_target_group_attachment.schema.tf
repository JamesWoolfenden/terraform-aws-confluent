resource "aws_lb_target_group_attachment" "schema" {
  count            = length(var.schema_subnets)
  target_group_arn = aws_lb_target_group.schema.arn
  target_id        = element(aws_instance.schema-registry.*.id, count.index)
  port             = 6668
}
