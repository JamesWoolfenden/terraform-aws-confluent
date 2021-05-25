resource "aws_lb_target_group" "schema" {
  name     = "SCHEMA"
  port     = 6668
  protocol = "TCP"
  vpc_id   = var.vpc_id

  stickiness {
    enabled = false
    type    = "lb_cookie"
  }


}
