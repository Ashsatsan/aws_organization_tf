output "dev_scp_id" {
  description = "The ID of the Dev SCP"
  value       = aws_organizations_policy.dev_scp.id
}

output "test_scp_id" {
  description = "The ID of the Test SCP"
  value       = aws_organizations_policy.test_scp.id
}

output "prod_scp_id" {
  description = "The ID of the Prod SCP"
  value       = aws_organizations_policy.prod_scp.id
}

output "shared_scp_id" {
  description = "The ID of the Shared SCP"
  value       = aws_organizations_policy.shared_scp.id
}
