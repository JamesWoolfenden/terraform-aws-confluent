data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.subnet_tag
  }
}
