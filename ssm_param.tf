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

provider "aws" {
  region = "us-west-2"
}

#variable "environment_type" {
#  type    = string
#  default = "nothing"
#}

resource "aws_ssm_parameter" "environment_type" {
  name        = "environment_type2"
  type        = "String"
  value       = "13" #var.environment_type
  description = "basic string  to see what terraform & GH are doing"
  tags = {
    CostCenter           = "CC5409"
    CustomerName         = "Hyland Software Inc"
    EnvironmentType      = "Production"
    Owner                = "CPEENBL"
    Platform             = "AWS Delivery"
    Product              = "OnBase"
    git_commit           = "62db65792452d6b9c935b1d2a9577554bec5744c"
    git_file             = "ssm_param.tf"
    git_last_modified_at = "2024-02-14 07:17:35"
    git_last_modified_by = "jim.weller@gmail.com"
    git_modifiers        = "jim.weller"
    git_org              = "jimweller"
    git_repo             = "tf-envs"
    source               = "yor"
    yor_name             = "environment_type"
    yor_trace            = "9480d18a-6909-4291-aeff-2430996b85fe"
  }
}
