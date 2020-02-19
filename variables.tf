variable "account_name" {
  description = "Name of AWS account type, Developerment. testing or production to help with naming"
  type        = string
  default     = "development"
}

variable "allowed_ranges" {
  type        = list
  default     = []
  description = "A list of allowed IPs that can connect"
}

variable "bastion_instance_type" {
  type        = string
  description = "Size of Bastion instance"
  default     = "t2.micro"
}

variable "bastion_private_ip" {
  description = "Allows you to specify the private IP"
  type        = string
  default     = ""
}

variable "bastion_subnet" {
  type        = string
  description = "The id name of the subnet to put the bastion in."
}

variable "broker_instance_type" {
  type        = string
  description = "Size of broker instance"
  default     = "t2.micro"
}

variable "broker_protocol" {
  type        = string
  description = "Broker protocol setting"
  default     = "SSL"
}

variable "client_instance_type" {
  type        = string
  description = "Size of client instance"
  default     = "t2.micro"
}

variable "confluent_broker_version" {
  type        = string
  description = "The AMI version number or label to reqtrieve from AWS"
  default     = ""
}

variable "confluent_connect_version" {
  type        = string
  description = "The AMI version number or label to reqtrieve from AWS"
  default     = ""
}

variable "confluent_control_version" {
  type        = string
  description = "The AMI version number or label to reqtrieve from AWS"
  default     = ""
}

variable "confluent_license" {
  type        = string
  default     = "123456789"
  description = "Your Confluent licence"
}

variable "confluent_schema_version" {
  type        = string
  description = "The AMI version number or label to retrieved from AWS"
  default     = ""
}

variable "confluent_zookeeper_version" {
  type        = string
  default     = ""
  description = "The AMI version number or label to retrieved from AWS"
}

variable "connect_instance_type" {
  type        = string
  description = "Size of broker instance"
  default     = "t2.micro"
}

variable "consumer_instance_type" {
  type        = string
  description = "Size of consumer instance"
  default     = "t2.micro"
}

variable "control_center_instance_type" {
  type        = string
  description = "Size of control center instance"
  default     = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "name" {
  type = string
}

variable "schema_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "source_ami_account_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "bastion_count" {
  default = 1
}

variable "allowed_connect_cluster_range" {
  type = list
}

variable "zk_subnets" {
  type = list
}

variable "control_center_subnets" {
  type = list
}

variable "private_subnets" {
  type = list
}

variable "producer_subnets" {
  type = list
}

variable "broker_subnets" {
  type = list
}

variable "consumer_subnets" {
  type = list
}

variable "broker_private_ip" {
  type = list
}

variable "control_center_private_ip" {
  type = list
}

variable "connect_private_ip" {
  type = list
}

variable "schema_private_ip" {
  type = list
}

variable "zk_private_ip" {
  type = list
}

variable "domain" {
  type = string
}

variable "common_tags" {
  type = map
}

variable "zookeeper" {
  type = map
  default = {
    instance_type        = "t2.micro"
    leader-listener-port = "5590"
    peer-listener-port   = "5580"
    client-listener-port = "5570"
  }
}

variable "subnet_tag" {
  default = "*Private*"
}
