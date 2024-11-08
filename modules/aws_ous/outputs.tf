output "ou_ids" {
  description = "The IDs of the created organizational units"
  value       = aws_organizations_organizational_unit.ou[*].id
}

output "ou_names" {
  description = "The names of the created organizational units"
  value       = aws_organizations_organizational_unit.ou[*].name
}
