# terraform-aws-confluent

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-ecr/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-ecr)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-ecr.svg)](https://github.com/JamesWoolfenden/terraform-aws-ecr/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-confluent.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-confluent/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-aws-confluent/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-confluent&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-aws-confluent/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-confluent&benchmark=INFRASTRUCTURE+SECURITY)

Terraform module to provision Confluent Kafka. This works with Confluent 4, you'll need to have built the AMI's that go with this. It's based a classic AWS 6 subnet (3 private 3 public in three AZs) model.

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

Include this repository as a module in your existing Terraform code, follow example-real not examplea as that is test data:

```hcl
module "confluent" {
  source                        = "github.com/JamesWoolfenden/terraform-aws-confluent"
  ami_id = {
    broker    = data.aws_ami.broker.id
    connect   = data.aws_ami.connect.id
    control   = data.aws_ami.control.id
    schema    = data.aws_ami.schema.id
    redhat    = data.aws_ami.redhat.id
    zookeeper = data.aws_ami.zookeeper.id
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
```

## Costs

```text
monthly cost estimate

Project: .

 Name                                                            Monthly Qty  Unit            Monthly Cost

 module.cluster.aws_instance.bastion[0]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 16  GB-months              $1.86

 module.cluster.aws_instance.brokers[0]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 ├─ root_block_device
 │  └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71
 ├─ ebs_block_device[0]
 │  └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00
 ├─ ebs_block_device[1]
 │  └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00
 └─ ebs_block_device[2]
    └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00

 module.cluster.aws_instance.brokers[1]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 ├─ root_block_device
 │  └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71
 ├─ ebs_block_device[0]
 │  └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00
 ├─ ebs_block_device[1]
 │  └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00
 └─ ebs_block_device[2]
    └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00

 module.cluster.aws_instance.brokers[2]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 ├─ root_block_device
 │  └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71
 ├─ ebs_block_device[0]
 │  └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00
 ├─ ebs_block_device[1]
 │  └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00
 └─ ebs_block_device[2]
    └─ Storage (general purpose SSD, gp2)                              4,000  GB-months            $464.00

 module.cluster.aws_instance.connect-cluster[0]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 60  GB-months              $6.96

 module.cluster.aws_instance.connect-cluster[1]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 60  GB-months              $6.96

 module.cluster.aws_instance.connect-cluster[2]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 60  GB-months              $6.96

 module.cluster.aws_instance.control-center[0]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                300  GB-months             $34.80

 module.cluster.aws_instance.control-center[1]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                300  GB-months             $34.80

 module.cluster.aws_instance.control-center[2]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                300  GB-months             $34.80

 module.cluster.aws_instance.schema-registry[0]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.schema-registry[1]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.schema-registry[2]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.zookeeper[0]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.zookeeper[1]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.zookeeper[2]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.zookeeper[3]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_instance.zookeeper[4]
 ├─ Instance usage (Linux/UNIX, on-demand, t2.micro)                     730  hours                  $9.64
 ├─ EC2 detailed monitoring                                                7  metrics                $2.10
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 32  GB-months              $3.71

 module.cluster.aws_lb.broker
 ├─ Network load balancer                                                730  hours                 $19.32
 └─ Load balancer capacity units                               Cost depends on usage: $0.006 per LCU-hours

 module.cluster.aws_lb.schema
 ├─ Network load balancer                                                730  hours                 $19.32
 └─ Load balancer capacity units                               Cost depends on usage: $0.006 per LCU-hours

 module.cluster.aws_route53_record.connect_cluster[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.connect_cluster[1]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.connect_cluster[2]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.control_centre[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.kafka[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.kafka[1]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.kafka[2]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_connect_cluster[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_connect_cluster[1]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_connect_cluster[2]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_control_centre[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_kafka[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_kafka[1]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_kafka[2]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_zookeeper[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_zookeeper[1]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_zookeeper[2]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_zookeeper[3]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.reverse_zookeeper[4]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.zookeeper[0]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.zookeeper[1]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.zookeeper[2]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.zookeeper[3]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_record.zookeeper[4]
 ├─ Standard queries (first 1B)                                Cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                   Cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                                 Cost depends on usage: $0.70 per 1M queries

 module.cluster.aws_route53_zone.reverse
 └─ Hosted zone                                                            1  months                 $0.50

 PROJECT TOTAL                                                                                   $4,594.35
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

No requirements.

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                | n/a     |
| <a name="provider_template"></a> [template](#provider_template) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                 | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_instance_profile.confluent_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)           | resource    |
| [aws_iam_role.confluent_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                   | resource    |
| [aws_iam_role_policy.confluent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                         | resource    |
| [aws_iam_role_policy_attachment.role-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource    |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                         | resource    |
| [aws_instance.brokers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                         | resource    |
| [aws_instance.connect-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                 | resource    |
| [aws_instance.control-center](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                  | resource    |
| [aws_instance.schema-registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                 | resource    |
| [aws_instance.zookeeper](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                                       | resource    |
| [aws_lb.broker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)                                                      | resource    |
| [aws_lb.schema](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)                                                      | resource    |
| [aws_lb_listener.broker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)                                    | resource    |
| [aws_lb_listener.schema](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)                                    | resource    |
| [aws_lb_target_group.broker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                            | resource    |
| [aws_lb_target_group.schema](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)                            | resource    |
| [aws_lb_target_group_attachment.brokers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)     | resource    |
| [aws_lb_target_group_attachment.schema](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment)      | resource    |
| [aws_route53_record.connect_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                     | resource    |
| [aws_route53_record.control_centre](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                      | resource    |
| [aws_route53_record.kafka](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                               | resource    |
| [aws_route53_record.reverse_connect_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)             | resource    |
| [aws_route53_record.reverse_control_centre](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)              | resource    |
| [aws_route53_record.reverse_kafka](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                       | resource    |
| [aws_route53_record.reverse_zookeeper](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                   | resource    |
| [aws_route53_record.zookeeper](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                           | resource    |
| [aws_route53_zone.reverse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone)                                 | resource    |
| [aws_security_group.bastions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                            | resource    |
| [aws_security_group.brokers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                             | resource    |
| [aws_security_group.connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                             | resource    |
| [aws_security_group.control-center](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                      | resource    |
| [aws_security_group.schema](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                              | resource    |
| [aws_security_group.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                                 | resource    |
| [aws_security_group.zookeepers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                          | resource    |
| [aws_vpc_endpoint_service.broker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service)                  | resource    |
| [aws_vpc_endpoint_service.schema](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_service)                  | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                        | data source |
| [aws_iam_policy_document.confluent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)              | data source |
| [aws_iam_policy_document.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)                    | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                          | data source |
| [template_file.broker_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                           | data source |
| [template_file.connect_cluster_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                  | data source |
| [template_file.control_centre_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                   | data source |
| [template_file.schema_registry_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                  | data source |
| [template_file.zookeeper_user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                        | data source |

## Inputs

| Name                                                                                                                     | Description                                                                          | Type        | Default                                                                                                                                                                                             | Required |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_account_name"></a> [account_name](#input_account_name)                                                    | Name of AWS account type e.g. Development. Testing or Production to help with naming | `string`    | `"development"`                                                                                                                                                                                     |    no    |
| <a name="input_allowed_connect_cluster_range"></a> [allowed_connect_cluster_range](#input_allowed_connect_cluster_range) | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_allowed_ranges"></a> [allowed_ranges](#input_allowed_ranges)                                              | A list of allowed IPs that can connect                                               | `list(any)` | `[]`                                                                                                                                                                                                |    no    |
| <a name="input_ami_id"></a> [ami_id](#input_ami_id)                                                                      | n/a                                                                                  | `any`       | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_bastion_count"></a> [bastion_count](#input_bastion_count)                                                 | n/a                                                                                  | `number`    | `1`                                                                                                                                                                                                 |    no    |
| <a name="input_bastion_instance_type"></a> [bastion_instance_type](#input_bastion_instance_type)                         | Size of Bastion instance                                                             | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_bastion_private_ip"></a> [bastion_private_ip](#input_bastion_private_ip)                                  | Allows you to specify the private IP                                                 | `string`    | `""`                                                                                                                                                                                                |    no    |
| <a name="input_bastion_subnet"></a> [bastion_subnet](#input_bastion_subnet)                                              | The id name of the subnet to put the bastion in.                                     | `string`    | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_broker_instance_type"></a> [broker_instance_type](#input_broker_instance_type)                            | Size of broker instance                                                              | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_broker_private_ip"></a> [broker_private_ip](#input_broker_private_ip)                                     | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_broker_protocol"></a> [broker_protocol](#input_broker_protocol)                                           | Broker protocol setting                                                              | `string`    | `"SSL"`                                                                                                                                                                                             |    no    |
| <a name="input_broker_subnets"></a> [broker_subnets](#input_broker_subnets)                                              | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_bucket_arn"></a> [bucket_arn](#input_bucket_arn)                                                          | n/a                                                                                  | `string`    | `""`                                                                                                                                                                                                |    no    |
| <a name="input_client_instance_type"></a> [client_instance_type](#input_client_instance_type)                            | Size of client instance                                                              | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_confluent_license"></a> [confluent_license](#input_confluent_license)                                     | Your Confluent licence                                                               | `string`    | `"123456789"`                                                                                                                                                                                       |    no    |
| <a name="input_connect_instance_type"></a> [connect_instance_type](#input_connect_instance_type)                         | Size of broker instance                                                              | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_connect_private_ip"></a> [connect_private_ip](#input_connect_private_ip)                                  | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_consumer_instance_type"></a> [consumer_instance_type](#input_consumer_instance_type)                      | Size of consumer instance                                                            | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_consumer_subnets"></a> [consumer_subnets](#input_consumer_subnets)                                        | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_control_center_instance_type"></a> [control_center_instance_type](#input_control_center_instance_type)    | Size of control center instance                                                      | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_control_center_private_ip"></a> [control_center_private_ip](#input_control_center_private_ip)             | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_control_center_subnets"></a> [control_center_subnets](#input_control_center_subnets)                      | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_domain"></a> [domain](#input_domain)                                                                      | n/a                                                                                  | `string`    | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_egress_range"></a> [egress_range](#input_egress_range)                                                    | n/a                                                                                  | `list(any)` | <pre>[<br> "0.0.0.0/0"<br>]</pre>                                                                                                                                                                   |    no    |
| <a name="input_key_name"></a> [key_name](#input_key_name)                                                                | n/a                                                                                  | `string`    | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_name"></a> [name](#input_name)                                                                            | n/a                                                                                  | `string`    | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_private_subnets"></a> [private_subnets](#input_private_subnets)                                           | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_private_zone"></a> [private_zone](#input_private_zone)                                                    | n/a                                                                                  | `any`       | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_producer_subnets"></a> [producer_subnets](#input_producer_subnets)                                        | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_roles"></a> [roles](#input_roles)                                                                         | n/a                                                                                  | `list(any)` | <pre>[<br> "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",<br> "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",<br> "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"<br>]</pre> |    no    |
| <a name="input_schema_instance_type"></a> [schema_instance_type](#input_schema_instance_type)                            | n/a                                                                                  | `string`    | `"t2.micro"`                                                                                                                                                                                        |    no    |
| <a name="input_schema_private_ip"></a> [schema_private_ip](#input_schema_private_ip)                                     | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_stunnel_cert"></a> [stunnel_cert](#input_stunnel_cert)                                                    | n/a                                                                                  | `any`       | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_vpc_cidr"></a> [vpc_cidr](#input_vpc_cidr)                                                                | n/a                                                                                  | `string`    | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                                      | n/a                                                                                  | `string`    | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_zk_private_ip"></a> [zk_private_ip](#input_zk_private_ip)                                                 | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_zk_subnets"></a> [zk_subnets](#input_zk_subnets)                                                          | n/a                                                                                  | `list(any)` | n/a                                                                                                                                                                                                 |   yes    |
| <a name="input_zookeeper"></a> [zookeeper](#input_zookeeper)                                                             | n/a                                                                                  | `map(any)`  | <pre>{<br> "client-listener-port": "5570",<br> "instance_type": "t2.micro",<br> "leader-listener-port": "5590",<br> "peer-listener-port": "5580"<br>}</pre>                                         |    no    |

## Outputs

| Name                                                              | Description |
| ----------------------------------------------------------------- | ----------- |
| <a name="output_bastion_ip"></a> [bastion_ip](#output_bastion_ip) | n/a         |
| <a name="output_public_dns"></a> [public_dns](#output_public_dns) | n/a         |
| <a name="output_public_ips"></a> [public_ips](#output_public_ips) | n/a         |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-aws-ecr/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-aws-ecr/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2022 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-ecr&url=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-ecr&url=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_email]: mailto:?subject=terraform-aws-ecr&body=https://github.com/jameswoolfenden/terraform-aws-ecr
