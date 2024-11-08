variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the inline IAM policy attached to the role"
  type        = string
}

variable "root_account_arn" {
  description = "ARN of the root account that can assume this role"
  type        = string
}

variable "policy_actions" {
  description = "List of allowed actions for the inline policy attached to the IAM role"
  type        = list(string)
  default     = ["ec2:DescribeInstances", "s3:ListBucket", "rds:DescribeDBInstances", "cloudwatch:ListMetrics", "cloudwatch:GetMetricData"]
}

variable "tags" {
  description = "Tags to assign to the IAM role"
  type        = map(string)
}




