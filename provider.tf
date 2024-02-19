terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "AKIA5JSXSZNESUHI454W"
  secret_key = "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"
}

