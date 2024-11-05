terraform {
    backend "s3" {
       bucket = "flow-tf-unitou"
       key = "terraform_ou.tf"
       region = "us-east-2"
    }
}

provider "random" {}

provider "aws" {
  region = "us-east-2"  # Replace with your preferred AWS region
}

provider "aws" {
  alias = "central"
  region = "us-west-1"
}

