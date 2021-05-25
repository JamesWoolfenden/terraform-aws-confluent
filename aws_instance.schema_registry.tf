resource "aws_instance" "schema-registry" {
  # checkov:skip=CKV2_AWS_17: Bad check
  ami        = data.aws_ami.schema.id
  count      = length(var.private_subnets)
  monitoring = true

  ebs_optimized          = true
  iam_instance_profile   = aws_iam_instance_profile.confluent_ssm.name
  instance_type          = var.schema_instance_type
  key_name               = var.key_name
  private_ip             = element(var.schema_private_ip, count.index)
  subnet_id              = element(var.private_subnets, count.index)
  user_data              = element(data.template_file.schema_registry_user_data.*.rendered, count.index)
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.schema.id]

  depends_on = [aws_lb.schema]

  root_block_device {
    volume_size = 32 # 32GB
    encrypted   = true
  }

  lifecycle {
    ignore_changes = [user_data]
  }
  metadata_options {
    http_tokens = "required"
  }
}
