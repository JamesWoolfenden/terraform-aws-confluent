resource "aws_lb" "schema" {
  #checkov:skip=CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled"
  internal                   = true
  load_balancer_type         = "network"
  subnets                    = [data.aws_subnet_ids.subnets.ids]
  enable_deletion_protection = false

  depends_on = [aws_instance.control-center]

  tags = var.common_tags
}
