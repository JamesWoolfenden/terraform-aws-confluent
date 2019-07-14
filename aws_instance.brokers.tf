resource "aws_instance" "brokers" {
  ami                    = data.aws_ami.broker.id
  count                  = length(var.broker_private_ip)
  iam_instance_profile   = aws_iam_instance_profile.confluent_ssm_profile.name
  instance_type          = var.broker_instance_type
  key_name               = var.key_name
  private_ip             = element(var.broker_private_ip, count.index)
  subnet_id              = element(var.broker_subnets, count.index)
  user_data              = element(data.template_file.broker_user_data.*.rendered, count.index)
  vpc_security_group_ids = [aws_security_group.brokers.id, aws_security_group.ssh.id]

  depends_on = ["aws_instance.zookeeper"]

  root_block_device {
    volume_size = 32 # 32GB
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    encrypted   = true
    volume_size = 4000 # 4tb
  }

  ebs_block_device {
    device_name = "/dev/sdg"
    encrypted   = true
    volume_size = 4000 # 4tb
  }

  ebs_block_device {
    device_name = "/dev/sdh"
    encrypted   = true
    volume_size = 4000 # 4tb
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags = var.common_tags
}
