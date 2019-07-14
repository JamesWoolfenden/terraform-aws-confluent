data "template_file" "connect_cluster_user_data" {
  count    = length(var.connect_private_ip)
  template = file("${path.module}/templates/cloud_init_connect_cluster.sh")

  vars {
    account_name        = var.account_name
    aws_id              = data.aws_caller_identity.current.account_id
    count               = count.index + 1
    private_dns_zone    = replace(data.aws_route53_zone.selected.name, "/[.]$/", "")
    broker_private_ip_0 = var.broker_private_ip[0]
    broker_private_ip_1 = var.broker_private_ip[1]
    broker_private_ip_2 = var.broker_private_ip[2]
    confluent_license   = var.confluent_license
  }
}
