output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.default_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.default_public_subnet[*].id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.default_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.default_public_rt.id
  description = "The ID of the public route table"
}
