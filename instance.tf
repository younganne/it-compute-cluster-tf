data "aws_ami" "ubuntu" {
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

resource "aws_instance" "prod" {
  ami = data.aws_ami.ubuntu.id
  #ami             = var.ubuntu-ami
  instance_type = var.ubuntu-instance-type
  subnet_id     = aws_subnet.subnet.id
  #key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.ssh-sg.id]
  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.keys.key_name

  #cpu_options {
  #  core_count       = 2
  #  threads_per_core = 2
  #}

  tags = {
    Name = "ubuntu-vm"
  }
}