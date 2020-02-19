# terraform-aws-confluent [![Build Status](https://api.travis-ci.com/JamesWoolfenden/terraform-aws-ecr.svg?branch=master)](https://travis-ci.com/JamesWoolfenden/terraform-aws-ecr) [![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-ecr.svg)](https://github.com/JamesWoolfenden/terraform-aws-ecr/releases/latest) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_name |  | string | n/a | yes |
| allowed\_connect\_cluster\_range |  | string | n/a | yes |
| allowed\_ips |  | list | `[]` | no |
| bastion\_count |  | string | `"1"` | no |
| bastion\_instance\_type | Size of Bastion instance | string | `"t2.micro"` | no |
| bastion\_private\_ip |  | string | n/a | yes |
| bastion\_subnet |  | string | n/a | yes |
| broker\_instance\_type | Size of broker instance | string | `"t2.micro"` | no |
| broker\_private\_ip |  | list | n/a | yes |
| broker\_protocol |  | string | n/a | yes |
| broker\_subnets |  | list | n/a | yes |
| client\_instance\_type | Size of client instance | string | `"t2.micro"` | no |
| common\_tags |  | map | n/a | yes |
| confluent\_broker\_version |  | string | n/a | yes |
| confluent\_connect\_version |  | string | n/a | yes |
| confluent\_control\_version |  | string | n/a | yes |
| confluent\_license |  | string | `"123456789"` | no |
| confluent\_schema\_version |  | string | `""` | no |
| confluent\_zookeeper\_version |  | string | `""` | no |
| connect\_instance\_type | Size of broker instance | string | `"t2.micro"` | no |
| connect\_private\_ip |  | list | n/a | yes |
| consumer\_instance\_type | Size of consumer instance | string | `"t2.micro"` | no |
| consumer\_subnets |  | list | n/a | yes |
| control\_center\_instance\_type | Size of control center instance | string | `"t2.micro"` | no |
| control\_center\_private\_ip |  | list | n/a | yes |
| control\_center\_subnets |  | list | n/a | yes |
| domain |  | string | n/a | yes |
| environment |  | string | n/a | yes |
| key\_name |  | string | n/a | yes |
| name |  | string | n/a | yes |
| private\_subnets |  | list | n/a | yes |
| producer\_subnets |  | list | n/a | yes |
| roles |  | list | `[ "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM", "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess", "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" ]` | no |
| schema\_instance\_type |  | string | `"t2.micro"` | no |
| schema\_private\_ip |  | list | n/a | yes |
| source\_ami\_account\_id |  | string | n/a | yes |
| vpc\_cidr |  | string | n/a | yes |
| zk\_private\_ip |  | list | n/a | yes |
| zk\_subnets |  | list | n/a | yes |
| zookeeper |  | map | `{ "client-listener-port": "5570", "instance_type": "t2.micro", "leader-listener-port": "5590", "peer-listener-port": "5580" }` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_ip |  |
| public\_dns |  |
| public\_ips |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-aws-ecr/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-aws-ecr/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2020 [Slalom, LLC](https://slalom.com)

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
[logo]: https://gist.githubusercontent.com/JamesWoolfenden/5c457434351e9fe732ca22b78fdd7d5e/raw/15933294ae2b00f5dba6557d2be88f4b4da21201/slalom-logo.png
[website]: https://slalom.com
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/company/slalom-consulting/
[twitter]: https://twitter.com/Slalom

[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-ecr&url=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-ecr&url=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_reddit]: https://reddit.com/submit/?url=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/jameswoolfenden/terraform-aws-ecr
[share_email]: mailto:?subject=terraform-aws-ecr&body=https://github.com/jameswoolfenden/terraform-aws-ecr
