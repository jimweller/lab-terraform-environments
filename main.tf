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
      key = "tf-environment-state-key"
      region = "us-west-2"
    }
}

provider "aws" {
  region = "us-west-2"
}

variable "environment_type" {
    type = string
    default = "nothing"
}

resource "aws_ssm_parameter" "foo" {
  name  = "environment_type"
  type  = "String"
  value = var.environment_type
  description = "basic string  to see what terraform & GH are doing"
  tags = {
    git_commit           = ""
    git_file             = ""
    git_last_modified_at = ""
    git_last_modified_by = ""
    git_modifiers        = ""
    git_org              = ""
    git_repo             = ""
    yor_trace            = ""
    yor_uuid             = ""
  }
}
