module "cluster" {
  source = "../../"
  ami_id = {
    broker    = data.aws_ami.redhat.id
    connect   = data.aws_ami.redhat.id
    control   = data.aws_ami.redhat.id
    schema    = data.aws_ami.redhat.id
    redhat    = data.aws_ami.redhat.id
    zookeeper = data.aws_ami.redhat.id
  }
  allowed_ranges                = var.allowed_ranges
  allowed_connect_cluster_range = var.allowed_connect_cluster_range
  account_name                  = var.account_name
  bastion_count                 = var.bastion_count
  bastion_private_ip            = local.bastion_private_ip
  bastion_subnet                = tolist(data.aws_subnet_ids.public.ids)[0]
  broker_subnets                = data.aws_subnet_ids.private.ids
  broker_private_ip             = local.broker_private_ip
  broker_protocol               = var.broker_protocol
  confluent_license             = var.confluent_license
  connect_private_ip            = local.connect_private_ip
  consumer_subnets              = tolist(data.aws_subnet_ids.private.ids)
  control_center_private_ip     = local.control_center_private_ip
  control_center_subnets        = tolist(data.aws_subnet_ids.private.ids)
  domain                        = var.domain
  key_name                      = "id_rsa.${var.account_name}"
  kms_key                       = aws_kms_key.example
  name                          = var.cluster_name
  producer_subnets              = [data.aws_subnet_ids.private.ids, data.aws_subnet_ids.private.ids]
  private_zone                  = data.aws_route53_zone.selected
  schema_private_ip             = local.schema_private_ip
  private_subnets               = tolist(data.aws_subnet_ids.private.ids)
  stunnel_cert                  = tls_private_key.example.private_key_pem
  vpc_cidr                      = data.aws_vpc.vpc.cidr_block
  vpc_id                        = local.vpc_id
  zk_private_ip                 = local.zk_private_ip
  zk_subnets                    = concat(tolist(data.aws_subnet_ids.private.ids), tolist(data.aws_subnet_ids.private.ids))
}
