resource "aws_instance" "bastion" {
  # checkov:skip=CKV_AWS_88: "Its a Bastion host!"
  count                       = var.bastion_count
  ami                         = data.aws_ami.redhat.id
  associate_public_ip_address = true
  monitoring                  = true

  ebs_optimized          = true
  iam_instance_profile   = aws_iam_instance_profile.confluent_ssm.name
  instance_type          = var.bastion_instance_type
  key_name               = var.key_name
  private_ip             = var.bastion_private_ip
  subnet_id              = var.bastion_subnet
  vpc_security_group_ids = [aws_security_group.bastions.id]
  depends_on             = [aws_security_group.bastions]

  lifecycle {
    ignore_changes = [user_data]
  }

  root_block_device {
    volume_size = 16
    encrypted   = true
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = var.common_tags
}
