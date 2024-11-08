resource "aws_organizations_account" "account" {
  name      = var.name
  email     = var.email
  role_name = "OrganizationAccountAccessRole"
  parent_id = var.parent_id

  tags = {
    Name = var.name
  }
}
