# This simple TF pushes an SSM param to show that something happened in AWS via
# the github action. The value of the environment_type paremeter will be
# determined by the .tfvars files in the env directory.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.7"

  # The bucket is not defined here. It will vary depending on dev or prod
  # environment. It comes from a github secret that is used on the tf command
  # line in the GH actions.
  backend "s3" {
    key    = "tf-environment-state-key"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "environment_type" {
  type    = string
  default = "nothing"
}

resource "aws_ssm_parameter" "environment_type" {
  name        = "environment_type1"
  type        = "String"
  value       = var.environment_type
  description = "basic string  to see what terraform & GH are doing"
  tags = {
    jim                  = "c"
    git_commit           = "69708264fabf702b7ae06f23eb874057a839524d"
    git_file             = "main.tf"
    git_last_modified_at = "2024-02-14 00:41:18"
    git_last_modified_by = "31997291+jimweller@users.noreply.github.com"
    git_modifiers        = "31997291+jimweller"
    git_org              = "jimweller"
    git_repo             = "tf-envs"
    yor_trace            = "tf-envs"
    yor_name             = "environment_type"
  }
}
