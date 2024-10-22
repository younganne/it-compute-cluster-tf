# AMI lookup for Ubuntu Server 24.04 
data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Managed resource for Ubuntu EC2 instance(s)
resource "aws_instance" "cluster_ec2" {
  for_each = toset(data.aws_subnets.subnets.ids)
  #count         = var.counter
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance_type
  key_name      = data.aws_key_pair.keys.key_name
  #subnet_id = data.aws_subnet.subnet.id
  subnet_id = each.value

  security_groups = [
    data.aws_security_group.security.id
  ]
  associate_public_ip_address = true

  depends_on = [aws_internet_gateway.cluster_gw]

  tags = {
    Name = "IT Compute Cluster"
  }
}
