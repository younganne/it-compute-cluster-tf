output "fingerprint" {
  value = data.aws_key_pair.keys.fingerprint
}

output "key-name" {
  value = data.aws_key_pair.keys.key_name
}

output "id" {
  value = data.aws_key_pair.keys.id
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.subnet : s.cidr_block]
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}