resource "aws_lb" "broker" {
  # checkov:skip=CKV_AWS_150: ADD REASON
  #checkov:skip=CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled"
  enable_deletion_protection       = false
  internal                         = true
  load_balancer_type               = "network"
  subnets                          = var.private_subnets
  drop_invalid_header_fields       = true
  depends_on                       = [aws_instance.brokers]
  enable_cross_zone_load_balancing = true
}
