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

  # The bucket is not defined here on purpose. It will vary depending on dev or
  # prod environment. It comes from a github secret that is used on the tf
  # command line in the GH actions.
  backend "s3" {
    key    = "tf-environment-state-key"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
}

# This variable is used to change the value of the ssm parameter between dev and
# prod. See the tfvars files in the env/ directory.
variable "environment_type" {
  type        = string
  default     = "nothing"
  description = "This variable is used to change the value of the ssm parameter between dev and prod. See the tfvars files in the env/ directory."
}

# This is the most basic terraform resource, a key and value in the SSM
# parameter store. It is a fast and easy way to test other things like github
# actions and other tooling.
#
# Note, that the tags will be populated by yor 
#
# Note, that the value comes from a variable assigned in the tfvars files in the
# env/ directory
resource "aws_ssm_parameter" "environment_type" {
  name        = "environment_type"
  type        = "String"
  value       = var.environment_type
  description = "A basic SSM parameter that will vary between DEV and PROD aws accounts according to the tfvars files in the env/ directory."
  # tags will be injected below  here by yor
  tags = {
    ChangeMeToTest       = "1"
    CostCenter           = "CC5409"
    CustomerName         = "Hyland Software Inc"
    EnvironmentType      = "Production"
    Owner                = "CPEENBL"
    Platform             = "AWS Delivery"
    Product              = "OnBase"
    git_commit           = "51047752fb8d8cad8ec0ddbd8973b82f78b4d37f"
    git_file             = "ssm_param.tf"
    git_last_modified_at = "2024-02-14 19:45:07"
    git_last_modified_by = "jim.weller@gmail.com"
    git_modifiers        = "31997291+jimweller/jim.weller"
    git_org              = "jimweller"
    git_repo             = "tf-envs"
    source               = "yor"
    yor_name             = "environment_type"
    yor_trace            = "f1ee83f3-444a-4e2b-97db-9da185f7e396"
  }
}
