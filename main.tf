# basic ssm param file
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }

    required_version = ">= 1.5.7"

    backend "s3" {
      key = "tf-environment-state-key"
      region = "us-west-2"
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}


resource "aws_ssm_parameter" "foo" {
  name  = "environment"
  type  = "String"
  value = var.environment.value
  description = "basic value to see what terraform & GH are doing"
}

