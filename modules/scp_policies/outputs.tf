output "dev_scp_id" {
  value = aws_organizations_policy.dev_scp.id
}

output "test_scp_id" {
  value = aws_organizations_policy.test_scp.id
}

output "prod_scp_id" {
  value = aws_organizations_policy.prod_scp.id
}
