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






