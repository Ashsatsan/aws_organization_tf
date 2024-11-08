resource "aws_cloudtrail" "shared_trail" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.bucket
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail_logs.arn
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_cloudwatch_role.arn
  is_organization_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  kms_key_id                    = var.kms_key_id

  tags = var.tags
}

resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = var.s3_bucket_name

  # Bucket policy to allow CloudTrail to write to this bucket
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": { "Service": "cloudtrail.amazonaws.com" },
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::${var.s3_bucket_name}/AWSLogs/*",
        "Condition": {
          "StringEquals": { "s3:x-amz-acl": "bucket-owner-full-control" }
        }
      }
    ]
  })
}

resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_iam_role" "cloudtrail_cloudwatch_role" {
  name               = var.cloudtrail_role_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": { "Service": "cloudtrail.amazonaws.com" },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudtrail_policy_attachment" {
  role       = aws_iam_role.cloudtrail_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
