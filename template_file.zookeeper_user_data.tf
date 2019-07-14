data "template_file" "zookeeper_user_data" {
  count    = length(var.zk_private_ip)
  template = file("${path.module}/templates/cloud_init_zookeeper.sh")

  vars = {
    account_name            = var.account_name
    aws_id                  = data.aws_caller_identity.current.account_id
    count                   = count.index
    number                  = count.index + 1
    private_dns_zone        = replace(data.aws_route53_zone.selected.name, "/[.]$/", "")
    stunnel_cert            = data.aws_s3_bucket_object.stunnel_cert.body
    zk-client-listener-port = var.zk-client-listener-port
    zk-leader-listener-port = var.zk-leader-listener-port
    zk-peer-listener-port   = var.zk-peer-listener-port
    zk_private_local_ip     = element(var.zk_private_ip, count.index)
    zk_private_ip_0         = var.zk_private_ip[0]
    zk_private_ip_1         = var.zk_private_ip[1]
    zk_private_ip_2         = var.zk_private_ip[2]
    zk_private_ip_3         = var.zk_private_ip[3]
    zk_private_ip_4         = var.zk_private_ip[4]
  }
}
