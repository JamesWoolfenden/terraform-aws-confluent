data "template_file" "schema_registry_user_data" {
  count    = length(var.broker_private_ip)
  template = file("${path.module}/templates/cloud_init_schema_registry.sh.template")

  vars = {
    account_name        = var.account_name
    aws_id              = data.aws_caller_identity.current.account_id
    count               = count.index + 1
    broker_protocol     = var.broker_protocol
    private_dns_zone    = replace(var.private_zone.name, "/[.]$/", "")
    broker_private_ip_0 = var.broker_private_ip[0]
    broker_private_ip_1 = var.broker_private_ip[1]
    broker_private_ip_2 = var.broker_private_ip[2]
    region              = data.aws_region.current.name
  }
}
