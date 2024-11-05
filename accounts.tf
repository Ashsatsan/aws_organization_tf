# Ensure you reference the OU IDs from the ou.tf
resource "aws_organizations_account" "dev_account" {
account_name  = "DevAccount"
email         = "ragowi5300@cironex.com"  # Ensure this email is unique
role_name     = "OrganizationAccountAccessRole"
parent_id     = aws_organizations_organizational_unit.dev.id  # Reference directly

tags = {
Name = "Development Account"
}
}

resource "aws_organizations_account" "test_account" {
account_name  = "TestAccount"
email         = "6qq7p@livinitlarge.net"  # Ensure this email is unique
role_name     = "OrganizationAccountAccessRole"
parent_id     = aws_organizations_organizational_unit.test.id  # Reference directly

tags = {
Name = "Testing Account"
}
}


