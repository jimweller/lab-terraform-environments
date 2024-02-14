# Jim's Terraform CI/CD Prototype

Demonstrates terraform continuous integration and continuous deployment (capital D) using
github actions.

## Pre-requities
* Two aws accounts, dev and prod
* An IAM user in each accounts that can create and delete SSM parameters and access the S3 buckets used for state
* ACCESS_KEY and ACCESS_SECRETS for each user in the respective accounts
* An s3 bucket in each account for tfstate
* The following values stored as github secrets in the repo
  * AWS_DEV_KEY - the AWS_ACCESS_KEY for dev account
  * AWS_DEV_SECRET - the AWS_SECRET_KEY for dev account
  * AWS_DEV_TFSTATE_S3 - the S3 bucket for terraform state for the dev account
  * AWS_PROD_KEY - the AWS_ACCESS_KEY for prod account
  * AWS_PROD_SECRET - the AWS_SECRET_KEY for prod account
  * AWS_PROD_TFSTATE_S3 - the S3 bucket for terraform state for the prod account

 ## Actions Taken
 * Any commits pushed to a non-`main` branch will do `terraform` `init`, `validate`, `plan`, and `apply`  to DEV AWS
* Deleting a non-`main` branch will do `terraform destroy` to DEV AWS
* Any commits pushed to `main` (merge PR) it does `terraform apply` to PROD AWS. E.g. when a PR is merged into `main`.

## Testing

```
# generate a unique number for branch, commit message, and PR
num=`date +%s`

# change something in ssm_parm.tf or a *.tfvars file, like edit a comment

# create a branch
gcb wf$num

# commit & push
gav . && gcmsg "$num" && ggpush

# [nothing should happen since the triggers are all PR based]

# create a PR
gh pr create -t "wf$num" -b "$num"

# [watch the tf-dev-cicd-pr.yml worklow run and create an SSM parameter in your aws dev account]

# merge the PR (with squash)
gh pr merge -s -d wf$num

# [watch the tf-dev-cleanup-pr.yml and tf-prod-cicd-pr.yml workflows run]
# [see the ssm paramenter is in aws prod and was destroyed in aws dev]

# switch to main and delete local/remote branches
gco main
gpod wf$num
gbD wf$num

# !IMPORTANT! yor moved your branch ahead by one commit. So, locally
# you need to do a git pull to get caught up to that change before you 
# modify any other files
gl
```

## References
- https://nathan.kewley.me/2020-07-21-deploy-to-AWS-using-terraform-and-github-actions/
- https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows




<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.environment_type](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | n/a | `string` | `"nothing"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->