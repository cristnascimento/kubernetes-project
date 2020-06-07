provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_vpc" "test_k8s_vpc" {
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"

  tags = {
    Name = "Test K8s VPC"
  }
}

resource "aws_internet_gateway" "test_k8s_gtw" {
  vpc_id = aws_vpc.test_k8s_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.test_k8s_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route" "r2" {
  route_table_id              = aws_route_table.r.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.test_k8s_gtw.id
}

resource "aws_subnet" "test_k8s_subnet" {
  vpc_id            = aws_vpc.test_k8s_vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = cidrsubnet(aws_vpc.test_k8s_vpc.cidr_block, 4, 1)
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Test K8s Subnet"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.test_k8s_subnet.id
  route_table_id = aws_route_table.r.id
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.test_k8s_vpc.id
  route_table_id = aws_route_table.r.id
}

output "vpc_id" {
  description = "Private vpc id"
  value       = aws_vpc.test_k8s_vpc.id
}

output "subnet_id" {
  description = "Private subnet id"
  value       = aws_subnet.test_k8s_subnet.id
}
