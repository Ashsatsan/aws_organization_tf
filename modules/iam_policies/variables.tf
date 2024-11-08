variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM role policy"
  type        = string
}

variable "root_account_arn" {
  description = "ARN of the root account for assuming the role"
  type        = string
}

variable "policy_actions" {
  description = "List of allowed actions for the policy"
  type        = list(string)
  default     = ["ec2:DescribeInstances", "s3:ListBucket", "rds:DescribeDBInstances", "cloudwatch:ListMetrics", "cloudwatch:GetMetricData"]
}

variable "tags" {
  description = "Tags to assign to the IAM role"
  type        = map(string)
}

variable "depends_on_accounts" {
  description = "List of account resources to depend on"
  type        = list(any)
}
