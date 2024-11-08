resource "aws_organizations_organizational_unit" "ou" {
  count      = length(var.ou_names)
  name       = var.ou_names[count.index]
  parent_id  = var.parent_id
}

