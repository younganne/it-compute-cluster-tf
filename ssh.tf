# Data source for existing AWS key pair
data "aws_key_pair" "keys" {
  key_name           = var.key-name
  include_public_key = true
}

/*/
# ED25519 key
resource "tls_private_key" "ed25519-key" {
  algorithm = "ED25519"
}

# Public key loaded from a terraform-generated private key, using the PEM (RFC 1421) format
data "tls_public_key" "private_key_pem" {
  private_key_pem = tls_private_key.ed25519-key.private_key_pem
}
/*/