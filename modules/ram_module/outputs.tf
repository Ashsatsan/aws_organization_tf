output "resource_share_arn" {
  description = "The ARN of the created resource share."
  value       = aws_ram_resource_share.this.arn
}

output "resource_association_arn" {
  description = "The status of the resource association."
  value       = aws_ram_resource_association.this.resource_arn
}

output "principal_association_principal" {
  description = "The status of the principal association."
  value       = aws_ram_principal_association.this.principal
}
