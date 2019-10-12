data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.confluent.id

  tags = {
    Name = var.subnet_tag
  }
}

