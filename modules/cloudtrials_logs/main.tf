# Create an S3 bucket to store CloudTrail logs
resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "${var.environment}-cloudtrail-logs-${var.account_id}"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-cloudtrail-bucket"
    }
  )
}

# S3 Bucket Policy to allow CloudTrail to write logs
resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailWrite",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "s3:PutObject",
        Resource  = "${aws_s3_bucket.cloudtrail_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}

# Create CloudTrail
resource "aws_cloudtrail" "this" {
  name                          = "${var.environment}-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  is_organization_trail         = var.is_organization_trail

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-cloudtrail"
    }
  )
}

# Optionally, create an SNS topic for notifications
resource "aws_sns_topic" "cloudtrail_topic" {
  count = var.enable_notifications ? 1 : 0

  name = "${var.environment}-cloudtrail-notifications"

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-cloudtrail-notifications"
    }
  )
}

resource "aws_sns_topic_policy" "cloudtrail_topic_policy" {
  count = var.enable_notifications ? 1 : 0

  arn    = aws_sns_topic.cloudtrail_topic[0].arn
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AWSCloudTrailSNSPolicy",
        Effect    = "Allow",
        Principal = { Service = "cloudtrail.amazonaws.com" },
        Action    = "SNS:Publish",
        Resource  = aws_sns_topic.cloudtrail_topic[0].arn
      }
    ]
  })
}
