resource "aws_lb" "broker" {
  #checkov:skip=CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled"
  enable_deletion_protection = false
  internal                   = true
  load_balancer_type         = "network"
  subnets                    = [data.aws_subnet_ids.subnets.id]
  drop_invalid_header_fields = true
  depends_on                 = [aws_instance.brokers]

  tags = var.common_tags
}
