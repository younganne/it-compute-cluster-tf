## Networking ##

# VPC resource
resource "aws_vpc" "test_env" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "IT Compute Cluster VPC"
  }
}

# Subnet resource
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.test_env.id
  cidr_block        = cidrsubnet(aws_vpc.test_env.cidr_block, 3, 1)
  availability_zone = var.availability_zone
}

# Security group resource to restrict/allow inbound connectivity
resource "aws_security_group" "security" {
  name   = "IT Compute Cluster security group"
  vpc_id = aws_vpc.test_env.id

}

# Add ingress rule for ICSI Office IPv4 address
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.security.id
  cidr_ipv4         = var.cidr-ipv4
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Add ingress rule for EC2 Instance Connect in us-west-2
resource "aws_vpc_security_group_ingress_rule" "allow_" {
  security_group_id = aws_security_group.security.id
  cidr_ipv4         = "18.237.140.160/29"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Internet gateway resource
resource "aws_internet_gateway" "test_env_gw" {
  vpc_id = aws_vpc.test_env.id
}

# Route table resource
resource "aws_route_table" "rt_table" {
  vpc_id = aws_vpc.test_env.id

  tags = {
    Name = "IT Compute Cluster route table"
  }
}

# Route resource for internet gateway
resource "aws_route" "route_a" {
  route_table_id         = aws_route_table.rt_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test_env_gw.id
}

# Route resource for local CIDR block
resource "aws_route" "route_b" {
  route_table_id         = aws_route_table.rt_table.id
  destination_cidr_block = "10.0.0.0/16"
  gateway_id             = "local"
}
