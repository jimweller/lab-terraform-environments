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

  required_version = "~> 1.5"

  # The bucket is not defined here. It will vary depending on dev or prod
  # environment. It comes from a github secret that is used on the tf command
  # line in the GH actions.
  backend "s3" {
    key    = "tf-environment-state-key"
    region = "us-west-2"
  }
}

locals {
  current_datetime = timestamp()
}

provider "aws" {
  region = "us-west-2"
}

variable "environment_type" {
  type    = string
  default = "nothing"
}

resource "aws_ssm_parameter" "environment_type" {
  name        = "environment_type"
  type        = "String"
  value       = local.current_datetime #var.environment_type
  description = "basic string  to see what terraform & GH are doing"
  # tags will be injected here by yor 1

  tags = {
    CostCenter           = "CC5409"
    CustomerName         = "Hyland Software Inc"
    EnvironmentType      = "Production"
    Owner                = "CPEENBL"
    Platform             = "AWS Delivery"
    Product              = "OnBase"
    git_commit           = "a62cfdaf185935d3227fb2d4d5bf10332bd899da"
    git_file             = "ssm_param.tf"
    git_last_modified_at = "2024-02-14 18:08:22"
    git_last_modified_by = "31997291+jimweller@users.noreply.github.com"
    git_modifiers        = "31997291+jimweller/jim.weller"
    git_org              = "jimweller"
    git_repo             = "tf-envs"
    source               = "yor"
    yor_name             = "environment_type"
    yor_trace            = "f1ee83f3-444a-4e2b-97db-9da185f7e396"
  }
}
