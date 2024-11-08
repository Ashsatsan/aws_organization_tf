output "cross_account_role_arn" {
  description = "ARN of the cross-account IAM role"
  value       = aws_iam_role.cross_account_role.id
}

output "cross_account_policy_arn" {
  description = "ARN of the cross-account IAM policy"
  value       = aws_iam_role_policy.cross_account_policy.id
}
