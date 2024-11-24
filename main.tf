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

module "iam_policies" {
  source = "./modules/iam_policies"

  policy_name         = var.policy_name
  role_name           = var.role_name
  root_account_arn    = var.root_account_arn
  tags                = {}
}

module "create_ous" {

 source    = "./modules/ous_module"
  parent_id = data.aws_organizations_organization.org.roots.0.id
}

module "create_dev_account" {
  source    = "./modules/accounts_provision"
  name      = "DevAccount"
  email     = var.emailer
  parent_id = module.create_ous.ou_ids["DEV"]
}

module "create_test_account" {
  source    = "./modules/accounts_provision"
  name      = "TestAccount"
  email     = var.emailer["TestAccount"]
  parent_id = module.create_ous.ou_ids["TEST"]
}

module "create_prod_account" {
  source    = "./modules/accounts_provision"
  name      = "ProdAccount"
  email     = var.emailer["ProdAccount"]
  parent_id = module.create_ous.ou_ids["PROD"]
}

module "create_shared_account" {
  source    = "./modules/accounts_provision"
  name      = "SharedServicesAccount"
  email     = var.emailer["SharedServicesAccount"]
  parent_id = module.create_ous.ou_ids["SHARED"]
}


module "scp_policies" {
  source      = "./modules/scp_policies"
  dev_ou_id   = module.create_ous.ou_ids["DEV"]
  test_ou_id  = module.create_ous.ou_ids["TEST"]
  prod_ou_id  = module.create_ous.ou_ids["PROD"]
  shared_ou_id = module.create_ous.ou_ids["SHARED"]
}

locals {
  ous = {
    DEV  = "OU_DEV_ID"
    TEST = "OU_TEST_ID"
    PROD = "OU_PROD_ID"
  }
}

# Sharing VPC
module "ram_share_vpc" {
  for_each           = local.ous
  source             = "./modules/ram_module"
  share_name         = "SharedVPCWith${each.key}"
  resource_arn       = "arn:aws:ec2:REGION:ACCOUNT_ID:vpc/VPC_ID"
  target_principal_arn = "arn:aws:organizations::ORGANIZATION_ID:ou/ROOT_ID/${each.value}"
}

# Sharing CloudTrail
module "ram_share_cloudtrail" {
  for_each           = local.ous
  source             = "./modules/ram_module"
  share_name         = "SharedCloudTrailWith${each.key}"
  resource_arn       = "arn:aws:cloudtrail:REGION:ACCOUNT_ID:trail/CLOUDTRAIL_NAME"
  target_principal_arn = "arn:aws:organizations::ORGANIZATION_ID:ou/ROOT_ID/${each.value}"
}


module "shared_vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-2a", "us-east-2b", "us-east-2c"]
  environment         = "shared"
  tags = {
    Project = "SharedServices"
    Owner   = "Admin"
  }
}

module "shared_cloudtrail" {
  source               = "./modules/shared_cloudtrails"
  environment          = "shared"
  account_id           = "123456789012"
  is_organization_trail = true
  enable_notifications = false
  tags = {
    Project = "SharedServices"
    Owner   = "Admin"
  }
}




