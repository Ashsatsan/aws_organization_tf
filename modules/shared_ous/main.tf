resource "aws_organizations_organizational_unit" "shared_ou" {
  name       = "shared"  # The shared container OU
  parent_id  = "r-xxxxxxxx"  # Parent ID (root OU or another shared parent OU)
}

resource "aws_organizations_organizational_unit" "child_ou" {
  count      = length(var.ou_names)
  name       = var.ou_names[count.index]
  parent_id  = aws_organizations_organizational_unit.shared_ou.id  # Use shared OU as the parent
}
