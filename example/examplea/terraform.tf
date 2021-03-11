terraform {
  required_providers {
    aws = {
      version = "3.31.0"
      source  = "hashicorp/aws"
    }

    template = {
      version = "2.2.0"
    }
  }
  required_version = ">= 0.14"
}
