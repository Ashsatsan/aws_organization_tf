resource "aws_ram_resource_share" "this" {
  name = var.share_name
  allow_external_principals = false # Only within the AWS Organization
  tags = var.tags
}

# Associate the shared resources with the RAM resource share
resource "aws_ram_principal_association" "this" {
  resource_share_arn = aws_ram_resource_share.this.arn
  principal          = var.target_principal_arn
}

# Add resources to the resource share
resource "aws_ram_resource_association" "this" {
  resource_share_arn = aws_ram_resource_share.this.arn
  resource_arn       = var.resource_arn
}
