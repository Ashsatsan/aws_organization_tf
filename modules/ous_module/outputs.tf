output "ou_ids" {
  description = "A map of the OU names and their IDs"
  value = { for k, v in aws_organizations_organizational_unit.ou : k => v.id }
}
