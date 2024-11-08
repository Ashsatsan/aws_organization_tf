terraform {
  backend "s3" {
    bucket = "flow-tf-unitou"
    key    = "terraform_ou.tf"
    region = "us-east-2"
  }
}

provider "random" {}

provider "aws" {
  region = "us-east-2" # Replace with your preferred AWS region
}

provider "aws" {
  alias  = "central"
  region = "us-west-1"
}

module "shared_ous" {
  source     = "./modules/shared_ous"
  ou_names   = ["Dev", "Test", "Prod"]
  parent_id  = "r-xxxxxxxx"
}

module "scp_policies" {
  source      = "./modules/scp_policies"
  dev_ou_id   = module.shared_ous.child_ou_ids[0]
  test_ou_id  = module.shared_ous.child_ou_ids[1]
  prod_ou_id  = module.shared_ous.child_ou_ids[2]
}



module "shared_cloudtrail" {
  source                     = "./modules/cloudtrail"
  cloudtrail_name            = "shared-cloudtrail"
  s3_bucket_name             = "my-org-cloudtrail-logs"
  cloudwatch_log_group_name  = "cloudtrail-log-group"
  log_retention_days         = 365
  cloudtrail_role_name       = "CloudTrailCloudWatchRole"
  kms_key_id                 = "arn:aws:kms:region:account-id:key/key-id"
  tags                       = { "Environment" = "Production" }
}


