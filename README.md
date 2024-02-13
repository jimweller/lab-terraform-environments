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

 

## References
- https://nathan.kewley.me/2020-07-21-deploy-to-AWS-using-terraform-and-github-actions/
- https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows