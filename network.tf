resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf-learning"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/16"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-learning"
  }
}

# Creating a security group to restrict/allow inbound connectivity
resource "aws_security_group" "ssh-sg" {
  name        = var.network-security-group-name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "nsg-inbound"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.ssh-sg.id
  ##cidr_ipv4         = aws_vpc.vpc.cidr_block
  cidr_ipv4   = var.cidr-ipv4
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_network_interface" "nw-if" {
  subnet_id       = aws_subnet.subnet.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.ssh-sg.id]

  attachment {
    instance     = aws_instance.prod.id
    device_index = 1
  }
}