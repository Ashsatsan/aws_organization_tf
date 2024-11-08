output "cloudtrail_id" {
  description = "ID of the CloudTrail"
  value       = aws_cloudtrail.shared_trail.id
}

output "cloudtrail_s3_bucket_name" {
  description = "Name of the S3 bucket where CloudTrail logs are stored"
  value       = aws_s3_bucket.cloudtrail_logs.bucket
}

output "cloudtrail_cloudwatch_log_group" {
  description = "CloudWatch Log Group for CloudTrail logs"
  value       = aws_cloudwatch_log_group.cloudtrail_logs.name
}
