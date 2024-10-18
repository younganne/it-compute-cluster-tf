output "fingerprint" {
  value = data.aws_key_pair.keys.fingerprint
}

output "key-name" {
  value = data.aws_key_pair.keys.key_name
}

output "id" {
  value = data.aws_key_pair.keys.id
}