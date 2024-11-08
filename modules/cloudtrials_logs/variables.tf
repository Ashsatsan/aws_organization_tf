variable "cloudtrail_name" {
  description = "Name of the CloudTrail"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket for storing CloudTrail logs"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group for CloudTrail logs"
  type        = string
}

variable "log_retention_days" {
  description = "Retention period for CloudWatch log group (in days)"
  type        = number
  default     = 365
}

variable "cloudtrail_role_name" {
  description = "Name of the IAM role for CloudTrail to assume for CloudWatch logging"
  type        = string
}

variable "kms_key_id" {
  description = "KMS Key ID for encrypting the CloudTrail logs"
  type        = string
  default     = ""  # Optional; can be empty if KMS encryption is not required
}

variable "tags" {
  description = "Tags to apply to CloudTrail and associated resources"
  type        = map(string)
}
