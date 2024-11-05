provider "random" {}

provider "aws" {
  region = "us-east-2"  # Replace with your preferred AWS region
}

provider "aws" {
  alias = "central"
  region = "us-west-1"
}

# S3 bucket for storing Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "not_require_just_testing_3848"  # Replace with a globally unique bucket name

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "example" {
  name           = "db_tf_org"
  billing_mode   = "PROVISIONED"
  hash_key       = "Id"  # Specify the attribute that holds the hash key

  attribute {
    name = "Id"
    type = "S"
  }



  # Additional configuration like range_key, etc.
}
