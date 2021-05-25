data "template_file" "control_centre_user_data" {
  count    = length(var.control_center_private_ip)
  template = file("${path.module}/templates/cloud_init_control_centre.sh.template")

  vars = {
    account_name        = var.account_name
    aws_id              = data.aws_caller_identity.current.account_id
    private_dns_zone    = replace(var.private_zone.name, "/[.]$/", "")
    broker_private_ip_0 = var.broker_private_ip[0]
    broker_private_ip_1 = var.broker_private_ip[1]
    broker_private_ip_2 = var.broker_private_ip[2]
    confluent_license   = var.confluent_license
    region              = data.aws_region.current.name
  }
}
