variable "vpc_id" {
  description = "ID of the primary VPC"
  type        = string
}

variable "peer_vpc_id" {
  description = "ID of the peer VPC"
  type        = string
}

variable "peer_region" {
  description = "Region of the peer VPC"
  type        = string
  default     = null
}

variable "route_table_id" {
  description = "Route table ID for the main VPC"
  type        = string
}

variable "peer_route_table_id" {
  description = "Route table ID for the peer VPC"
  type        = string
}

variable "destination_cidr_blocks" {
  description = "List of destination CIDR blocks for routes to the peer VPC"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the VPC peering connection"
  type        = map(string)
}
