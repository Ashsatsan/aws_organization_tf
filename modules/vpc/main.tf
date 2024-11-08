resource "aws_vpc" "default_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      "Name" = var.vpc_name
    }
  )
}

resource "aws_internet_gateway" "default_igw" {
  vpc_id = aws_vpc.default_vpc.id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.vpc_name}-igw"
    }
  )
}

resource "aws_subnet" "default_public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.default_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      "Name" = "${var.vpc_name}-public-${count.index + 1}"
    }
  )
}

resource "aws_route_table" "default_public_rt" {
  vpc_id = aws_vpc.default_vpc.id

  tags = merge(
    var.tags,
    {
      "Name" = "${var.vpc_name}-public-rt"
    }
  )
}

resource "aws_route" "default_internet_route" {
  route_table_id         = aws_route_table.default_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default_igw.id
}

resource "aws_route_table_association" "default_public_rt_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.default_public_subnet[count.index].id
  route_table_id = aws_route_table.default_public_rt.id
}
