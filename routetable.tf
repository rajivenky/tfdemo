resource "aws_route_table" "pubroutetable" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }

  tags = {
    Name = "pubroutetable"
    environment = "dev"
    project = "learntf"
  }
}
resource "aws_route_table_association" "pubsubnetA" {
  subnet_id = aws_subnet.pubsubnetA.id
  route_table_id = aws_route_table.pubroutetable.id
}
resource "aws_route_table_association" "pubsubnetB" {
  subnet_id  = aws_subnet.pubsubnetB.id
  route_table_id = aws_route_table.pubroutetable.id
}
resource "aws_route_table_association" "pubsubnetC" {
  subnet_id = aws_subnet.pubsubnetC.id
  route_table_id = aws_route_table.pubroutetable.id

}
resource "aws_route_table" "priroutetable" {
  vpc_id = aws_vpc.myvpc.id
  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynatgw.id
  }

  tags = {
    Name = "priroutetable"
    environment = "dev"
    project = "learntf"
  }
}
resource "aws_route_table_association" "prisubnetA" {
  subnet_id = aws_subnet.prisubnetA.id
  route_table_id = aws_route_table.priroutetable.id
}
resource "aws_route_table_association" "prisubnetB" {
  subnet_id = aws_subnet.prisubnetB.id
  route_table_id = aws_route_table.priroutetable.id
}
resource "aws_route_table_association" "prisubnetC" {
  subnet_id = aws_subnet.prisubnetC.id
  route_table_id = aws_route_table.priroutetable.id
}
