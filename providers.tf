terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.43.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
    required_version = "1.12.2"
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  session_token = var.session_token
  default_tags {
    tags = var.tags
  }
}
