data "template_file" "broker_user_data" {
  count    = length(var.broker_private_ip)
  template = file("${path.module}/templates/cloud_init_kafka_broker.sh.template")

  vars = {
    account_name     = var.account_name
    aws_id           = data.aws_caller_identity.current.account_id
    count            = count.index + 1
    private_dns_zone = replace(data.aws_route53_zone.selected.name, "/[.]$/", "")
  }
}
