output "cloudtrail_name" {
  description = "The name of the CloudTrail"
  value       = aws_cloudtrail.this.name
}

output "cloudtrail_bucket" {
  description = "The S3 bucket used for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_bucket.bucket
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic for notifications"
  value       = aws_sns_topic.cloudtrail_topic[0].arn
}
