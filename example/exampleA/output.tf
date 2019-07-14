output "broker-ip" {
  value = local.broker_private_ip
}

output "private_cidrs" {
  value = data.aws_subnet.private.*.cidr_block
}

output "public_cidrs" {
  value = data.aws_subnet.public.*.cidr_block
}
