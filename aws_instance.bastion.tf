resource "aws_instance" "bastion" {
  count                       = var.bastion_count
  ami                         = data.aws_ami.redhat.id
  instance_type               = var.bastion_instance_type
  private_ip                  = var.bastion_private_ip
  iam_instance_profile        = aws_iam_instance_profile.confluent_ssm.name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastions.id]
  subnet_id                   = var.bastion_subnet
  key_name                    = var.key_name

  depends_on = [aws_security_group.bastions]

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = var.common_tags
}
