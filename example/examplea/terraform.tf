terraform {
  required_providers {
    aws = {
      version = "3.11.0"
      source  = "hashicorp/aws"
    }

    template = {
      version = "2.1.2"
    }
  }
}
