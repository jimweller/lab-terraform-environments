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
      bucket = "nothing"
      key = "tf-environment-state-key"
      region = "us-west-2"
    }
}

variable "environment_type" {
    type = string
    default = "dev"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}


resource "aws_ssm_parameter" "foo" {
  name  = "environment"
  type  = "String"
  value = var.environment_type
  description = "basic value to see what terraform & GH are doing"
}

