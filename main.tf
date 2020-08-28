provider "aws" {
  region = "ap-southeast-1"
  version = "~> 3.4"
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true 
}

resource "aws_subnet" "public_subnets" {
  for_each = var.network
  vpc_id            = aws_vpc.this.id
  availability_zone = each.value["availability_zone"]
  cidr_block        = each.value["cidr_block"]
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "this" {
  for_each       = var.network
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.this.id
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id     = aws_vpc.this.id
  depends_on = [
    aws_subnet.public_subnets
  ]
}

