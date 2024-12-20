data "aws_organizations_organization" "org" {}

resource "aws_organizations_organizational_unit" "dev" {
  name      = "DEV"
  parent_id = data.aws_organizations_organization.org.roots.0.id
}
resource "aws_organizations_organizational_unit" "test" {
  name      = "TEST"
  parent_id = data.aws_organizations_organization.org.roots.0.id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "PROD"
  parent_id = data.aws_organizations_organization.org.roots.0.id
}
