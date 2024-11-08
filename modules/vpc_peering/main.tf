resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_region   = var.peer_region # Set the peer region if the VPCs are in different regions
  auto_accept   = true
  tags = var.tags
}

resource "aws_route" "peer_route_vpc" {
  count                   = length(var.destination_cidr_blocks)
  route_table_id          = var.route_table_id
  destination_cidr_block  = var.destination_cidr_blocks[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "peer_route_peer_vpc" {
  count                   = length(var.destination_cidr_blocks)
  route_table_id          = var.peer_route_table_id
  destination_cidr_block  = var.destination_cidr_blocks[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
