terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.16.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
resource "aws_vpc"  "myvpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "myvpc"
    environment = "dev"
project = "learntf"
  }
}
resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "mygw"
    environment = "dev"
    project = "learntf"
  }
}
resource "aws_subnet" "pubsubnetA" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "pubsubnetA"
    environment = "dev"
    project = "learntf"
  }
}
resource "aws_subnet" "pubsubnetB" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "pubsubnetB"
    environment = "dev"
    project = "learntf"
  }
}
resource "aws_subnet" "pubsubnetC" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.3.0/24"

  tags = {
    Name = "pubsubnetC"
    environment = "dev"
    project = "learntf"
  }
 }
 resource "aws_subnet" "prisubnetA" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.4.0/24"

  tags = {
    Name = "prisubnetA"
    environment = "dev"
    project = "learntf"
  }
 }
 resource "aws_subnet" "prisubnetB" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.5.0/24"

  tags = {
    Name = "prisubnetB"
    environment = "dev"
    project = "learntf"
  } 
 }
 resource "aws_subnet" "prisubnetC" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.10.6.0/24"

  tags = {
    Name = "prisubnetC"
    environment = "dev"
    project = "learntf"
  } 
}
  resource "aws_eip" "myeip" {
  vpc      = true  
  tags = {
  Name = "myeip" 
    environment = "dev"
    project = "learntf"
  } 
}

resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pubsubnetA.id

  tags = {
    Name = "mynatgw"
    environment = "dev"
    project = "learntf"
    }
      # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.mygw]
}
  
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
