resource "aws_instance" "zookeeper" {
  count                = length(var.zk_private_ip)
  ami                  = data.aws_ami.zookeeper.id
  instance_type        = var.zookeeper["instance_type"]
  private_ip           = element(var.zk_private_ip, count.index)
  iam_instance_profile = aws_iam_instance_profile.confluent_ssm_profile.name

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.zookeepers.id,
  ]

  subnet_id = element(var.zk_subnets, count.index)
  key_name  = var.key_name
  user_data = element(data.template_file.zookeeper_user_data.*.rendered, count.index)

  root_block_device {
    volume_size = 32
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags = var.common_tags
}
