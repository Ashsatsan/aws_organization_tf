output "shared_ou_id" {
  description = "ID of the shared organizational unit."
  value       = aws_organizations_organizational_unit.shared_ou.id
}

output "child_ou_ids" {
  description = "The IDs of the created child organizational units."
  value       = aws_organizations_organizational_unit.child_ou[*].id
}
