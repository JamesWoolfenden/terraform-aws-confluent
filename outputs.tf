output "public_ips" {
  value = [aws_instance.brokers.*.public_ip]
}

output "public_dns" {
  value = [aws_instance.brokers.*.public_dns]
}

output "bastion_ip" {
  value = [aws_instance.bastion.*.public_dns]
}
