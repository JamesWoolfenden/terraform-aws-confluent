terraform {
  required_providers {

    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "6.43.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.2.1"
    }
  }
  required_version = ">=0.14.8"
}
