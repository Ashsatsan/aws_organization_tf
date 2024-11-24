terraform {
  backend "s3" {
    bucket = "flow-tf-unit_ou"
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

module "iam_policies" {
  source = "./modules/iam_policies"

  policy_name         = var.policy_name
  role_name           = var.role_name
  root_account_arn    = var.root_account_arn
  tags                = {}
}

module "create_ous" {
  source    = "./modules/ous"
  parent_id = data.aws_organizations_organization.org.roots.0.id
}

module "scp_policies" {
  source      = "./modules/scp_policies"
  dev_ou_id   = module.create_ous.ou_ids["DEV"]
  test_ou_id  = module.create_ous.ou_ids["TEST"]
  prod_ou_id  = module.create_ous.ou_ids["PROD"]
  shared_ou_id = module.create_ous.ou_ids["SHARED"]
}



module "shared_cloudtrail" {
  source                     = "./modules/cloudtrials_logs"
  cloudtrail_name            = "shared-cloudtrail"
  s3_bucket_name             = "my-org-cloudtrail-logs"
  cloudwatch_log_group_name  = "cloudtrail-log-group"
  log_retention_days         = 365
  cloudtrail_role_name       = "CloudTrailCloudWatchRole"
  kms_key_id                 = "arn:aws:kms:region:account-id:key/key-id"
  tags                       = { "Environment" = "Production" }
}

module "shared_vpc_dev" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  vpc_name            = "shared-dev-vpc"
  tags                = { "Environment" = "Dev" }
}

module "shared_vpc_test" {
  source              = "./modules/vpc"
  cidr_block          = "10.1.0.0/16"
  public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
  vpc_name            = "shared-test-vpc"
  tags                = { "Environment" = "Test" }
}

module "shared_vpc_prod" {
  source              = "./modules/vpc"
  cidr_block          = "10.2.0.0/16"
  public_subnet_cidrs = ["10.2.1.0/24", "10.2.2.0/24"]
  vpc_name            = "shared-prod-vpc"
  tags                = { "Environment" = "Prod" }
}

module "vpc_peering_dev_test" {
  source               = "./modules/vpc_peering"
  vpc_id               = module.shared_vpc_dev.vpc_id
  peer_vpc_id          = module.shared_vpc_test.vpc_id
  route_table_id       = module.shared_vpc_dev.public_route_table_id
  peer_route_table_id  = module.shared_vpc_test.public_route_table_id
  destination_cidr_blocks = ["10.1.0.0/16", "10.0.0.0/16"]
  tags                 = { "Environment" = "Dev-Test-Peering" }
}

module "vpc_peering_dev_prod" {
  source               = "./modules/vpc_peering"
  vpc_id               = module.shared_vpc_dev.vpc_id
  peer_vpc_id          = module.shared_vpc_prod.vpc_id
  route_table_id       = module.shared_vpc_dev.public_route_table_id
  peer_route_table_id  = module.shared_vpc_prod.public_route_table_id
  destination_cidr_blocks = ["10.2.0.0/16", "10.0.0.0/16"]
  tags                 = { "Environment" = "Dev-Prod-Peering" }
}

module "vpc_peering_test_prod" {
  source               = "./modules/vpc_peering"
  vpc_id               = module.shared_vpc_test.vpc_id
  peer_vpc_id          = module.shared_vpc_prod.vpc_id
  route_table_id       = module.shared_vpc_test.public_route_table_id
  peer_route_table_id  = module.shared_vpc_prod.public_route_table_id
  destination_cidr_blocks = ["10.2.0.0/16", "10.1.0.0/16"]
  tags                 = { "Environment" = "Test-Prod-Peering" }
}


