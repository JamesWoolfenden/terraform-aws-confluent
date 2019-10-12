resource "aws_instance" "connect-cluster" {
  ami                    = data.aws_ami.connect.id
  count                  = length(var.private_subnets)
  iam_instance_profile   = aws_iam_instance_profile.confluent_ssm.name
  instance_type          = var.connect_instance_type
  key_name               = var.key_name
  private_ip             = element(var.connect_private_ip, count.index)
  subnet_id              = element(var.private_subnets, count.index)
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.connect.id]

  user_data = element(data.template_file.connect_cluster_user_data.*.rendered, count.index)

  depends_on = ["aws_instance.schema-registry"]

  root_block_device {
    volume_size = 60 # 60GB
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags = var.common_tags
}
