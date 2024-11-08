// outputs.tf in the root directory
output "dev_ou_id" {
  value = aws_organizations_organizational_unit.dev.id
}

output "test_ou_id" {
  value = aws_organizations_organizational_unit.test.id
}

output "prod_ou_id" {
  value = aws_organizations_organizational_unit.prod.id
}
