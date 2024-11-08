output "account_id" {
  description = "The ID of the created AWS account"
  value       = aws_organizations_account.account.id
}

output "account_email" {
  description = "The email associated with the created AWS account"
  value       = aws_organizations_account.account.email
}
