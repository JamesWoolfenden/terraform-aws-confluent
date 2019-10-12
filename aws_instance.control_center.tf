resource "aws_instance" "control-center" {
  ami                    = data.aws_ami.control.id
  count                  = length(var.control_center_subnets)
  iam_instance_profile   = aws_iam_instance_profile.confluent_ssm.name
  instance_type          = var.control_center_instance_type
  key_name               = var.key_name
  private_ip             = element(var.control_center_private_ip, count.index)
  subnet_id              = element(var.control_center_subnets, count.index)
  user_data              = element(data.template_file.control_centre_user_data.*.rendered, count.index)
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.control-center.id]

  depends_on = ["aws_lb.broker"]

  root_block_device {
    volume_size = 300 # 300 GB
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }

  tags = var.common_tags
}
