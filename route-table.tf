resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc_golunch.id

  // Rota local
  route {
    cidr_block = aws_vpc.vpc_golunch.cidr_block
    gateway_id = "local"
  }

  // Rota exposta para o mundo (internet)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_association_0" {
  subnet_id      = aws_subnet.subnet_public[0].id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "rt_association_1" {
  subnet_id      = aws_subnet.subnet_public[1].id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_route_table_association" "rt_association_2" {
  subnet_id      = aws_subnet.subnet_public[2].id
  route_table_id = aws_route_table.route_table_public.id
}