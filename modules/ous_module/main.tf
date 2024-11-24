resource "aws_organizations_organizational_unit" "ou" {
  for_each = var.ous

  name      = each.key      # The OU name (Dev, Test, Prod, Shared)
  parent_id = var.parent_id # Root node ID, passed as input
}

