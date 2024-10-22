variable "key-name" {
  type = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "instance_type" {
  description = "instance_type"
  type        = string
}

variable "counter" {
  description = "Number of instances to launch"
  type        = number
}

variable "cidr_block" {
  description = "CIDR Block"
  type        = string
}

variable "subnet_cidr" {
  description = "subnet CIDR Block"
  type        = string
}

variable "ingress-ipv4" {
  description = "CIDR block for security group ingress rules"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zones for the Subnet"
  type        = string
}