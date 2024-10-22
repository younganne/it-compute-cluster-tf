## Networking ##
#
# Existing default VPC data source
data "aws_vpc" "cluster_vpc" {
  cidr_block = var.cidr_block
  /*/
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "IT Compute Cluster VPC"
  }
/*/
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Subnet data source for 1 or more availability zones
data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

# Internet gateway resource
resource "aws_internet_gateway" "cluster_gw" {
  vpc_id = data.aws_vpc.cluster_vpc.id

  tags = {
    Name = "IT Compute Cluster Internet Gateway"
  }
}

# Security group resource to restrict/allow inbound connectivity
data "aws_security_group" "security" {
  name   = "default"
  id     = var.security_group_id
  vpc_id = data.aws_vpc.cluster_vpc.id

}

data "aws_route_table" "rt_table" {
  vpc_id = var.vpc_id
}

# Route resource for local CIDR block
data "aws_route" "route_a" {
  route_table_id         = data.aws_route_table.rt_table.id
  destination_cidr_block = var.cidr_block
  gateway_id             = "local"
}

# Route to internet gateway
resource "aws_route" "route_b" {
  route_table_id         = data.aws_route_table.rt_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.cluster_gw.id
}

# Add IPv4 ingress rule for SSH
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = data.aws_security_group.security.id
  cidr_ipv4         = var.ingress-ipv4
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Add ingress rule for EC2 Instance Connect in us-west-2
resource "aws_vpc_security_group_ingress_rule" "allow_ec2_instance_connect" {
  security_group_id = data.aws_security_group.security.id
  cidr_ipv4         = "18.237.140.160/29"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
