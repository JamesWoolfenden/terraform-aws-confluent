# terraform-aws-confluent

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-ecr/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-ecr)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-ecr.svg)](https://github.com/JamesWoolfenden/terraform-aws-ecr/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

Terraform module to provision Confluent Kafka. This works with Confluent 4, you'll need to have built the AMI's that go with this. It's based a classic AWS 6 subnet (3 private 3 public in three AZs) model.

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "confluent" {
  source                        = "github.com/JamesWoolfenden/terraform-aws-confluent"
  allowed_ranges                = var.allowed_ranges
  allowed_connect_cluster_range = var.allowed_connect_cluster_range
  account_name                  = var.account_name
  bastion_count                 = var.bastion_count
  bastion_private_ip            = local.bastion_private_ip
  bastion_subnet                = data.aws_subnet_ids.public.ids
  broker_subnets                = data.aws_subnet_ids.private.ids
  broker_private_ip             = local.broker_private_ip
  broker_protocol               = var.broker_protocol
  common_tags                   = var.common_tags
  confluent_broker_version      = var.confluent_broker_version
  confluent_connect_version     = var.confluent_connect_version
  confluent_control_version     = var.confluent_control_version
  confluent_license             = var.confluent_license
  confluent_schema_version      = var.confluent_schema_version
  confluent_zookeeper_version   = var.confluent_zookeeper_version
  connect_private_ip            = local.connect_private_ip
  consumer_subnets              = [data.aws_subnet_ids.private.ids]
  control_center_private_ip     = local.control_center_private_ip
  control_center_subnets        = [data.aws_subnet_ids.private.ids]
  domain                        = var.domain
  key_name                      = "id_rsa.${var.account_name}"
  name                          = var.cluster_name
  producer_subnets              = [data.aws_subnet_ids.private.ids, data.aws_subnet_ids.private.ids]
  schema_private_ip             = local.schema_private_ip
  private_subnets               = [data.aws_subnet_ids.private.ids]
  source_ami_account_id         = data.aws_caller_identity.current.account_id
  vpc_cidr                      = data.aws_vpc.vpc.cidr_block
  zk_private_ip                 = local.zk_private_ip
  zk_subnets                    = [data.aws_subnet_ids.private.ids, data.aws_subnet_ids.private.ids, data.aws_subnet_ids.private.ids, data.aws_subnet_ids.private.ids, data.aws_subnet_ids.private.ids]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

No requirements.

## Providers

| Name     | Version |
| -------- | ------- |
| aws      | n/a     |
| template | n/a     |

## Inputs

| Name                          | Description                                                                        | Type     | Default                                                                                                                                                                                             | Required |
| ----------------------------- | ---------------------------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| account_name                  | Name of AWS account type, Developerment. testing or production to help with naming | `string` | `"development"`                                                                                                                                                                                     |    no    |
| allowed_connect_cluster_range | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| allowed_ranges                | A list of allowed IPs that can connect                                             | `list`   | `[]`                                                                                                                                                                                                |    no    |
| bastion_count                 | n/a                                                                                | `number` | `1`                                                                                                                                                                                                 |    no    |
| bastion_instance_type         | Size of Bastion instance                                                           | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| bastion_private_ip            | Allows you to specify the private IP                                               | `string` | `""`                                                                                                                                                                                                |    no    |
| bastion_subnet                | The id name of the subnet to put the bastion in.                                   | `string` | n/a                                                                                                                                                                                                 |   yes    |
| broker_instance_type          | Size of broker instance                                                            | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| broker_private_ip             | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| broker_protocol               | Broker protocol setting                                                            | `string` | `"SSL"`                                                                                                                                                                                             |    no    |
| broker_subnets                | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| client_instance_type          | Size of client instance                                                            | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| common_tags                   | n/a                                                                                | `map`    | n/a                                                                                                                                                                                                 |   yes    |
| confluent_broker_version      | The AMI version number or label to reqtrieve from AWS                              | `string` | `""`                                                                                                                                                                                                |    no    |
| confluent_connect_version     | The AMI version number or label to reqtrieve from AWS                              | `string` | `""`                                                                                                                                                                                                |    no    |
| confluent_control_version     | The AMI version number or label to reqtrieve from AWS                              | `string` | `""`                                                                                                                                                                                                |    no    |
| confluent_license             | Your Confluent licence                                                             | `string` | `"123456789"`                                                                                                                                                                                       |    no    |
| confluent_schema_version      | The AMI version number or label to retrieved from AWS                              | `string` | `""`                                                                                                                                                                                                |    no    |
| confluent_zookeeper_version   | The AMI version number or label to retrieved from AWS                              | `string` | `""`                                                                                                                                                                                                |    no    |
| connect_instance_type         | Size of broker instance                                                            | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| connect_private_ip            | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| consumer_instance_type        | Size of consumer instance                                                          | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| consumer_subnets              | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| control_center_instance_type  | Size of control center instance                                                    | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| control_center_private_ip     | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| control_center_subnets        | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| domain                        | n/a                                                                                | `string` | n/a                                                                                                                                                                                                 |   yes    |
| key_name                      | n/a                                                                                | `string` | n/a                                                                                                                                                                                                 |   yes    |
| name                          | n/a                                                                                | `string` | n/a                                                                                                                                                                                                 |   yes    |
| private_subnets               | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| producer_subnets              | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| roles                         | n/a                                                                                | `list`   | <pre>[<br> "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",<br> "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",<br> "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"<br>]</pre> |    no    |
| schema_instance_type          | n/a                                                                                | `string` | `"t2.micro"`                                                                                                                                                                                        |    no    |
| schema_private_ip             | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| source_ami_account_id         | n/a                                                                                | `string` | n/a                                                                                                                                                                                                 |   yes    |
| subnet_tag                    | n/a                                                                                | `string` | `"*Private*"`                                                                                                                                                                                       |    no    |
| vpc_cidr                      | n/a                                                                                | `string` | n/a                                                                                                                                                                                                 |   yes    |
| zk_private_ip                 | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| zk_subnets                    | n/a                                                                                | `list`   | n/a                                                                                                                                                                                                 |   yes    |
| zookeeper                     | n/a                                                                                | `map`    | <pre>{<br> "client-listener-port": "5570",<br> "instance_type": "t2.micro",<br> "leader-listener-port": "5590",<br> "peer-listener-port": "5580"<br>}</pre>                                         |    no    |

## Outputs

| Name       | Description |
| ---------- | ----------- |
| bastion_ip | n/a         |
| public_dns | n/a         |
| public_ips | n/a         |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-aws-ecr/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-aws-ecr/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2020 James Woolfenden

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
