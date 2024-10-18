data "aws_key_pair" "keys" {
  key_name           = "blog-keys"
  #key_pair_id        = "key-0a89a7a13bdac2107"
  include_public_key = true
}

resource "aws_iam_user" "user" {
  name = "anne"
  path = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = aws_iam_user.user.name
  encoding   = "SSH"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRx6UruaMYVkXDOt2nzn51F2RpUVpa7JdE1HzP4T/2xuozjlyGmPs7nLISNDnnNOfDgzwxhIGNSBnCxj9bIWM0RMXwXW7rh8AcjwUyhrQ2rXj7HxxJFJCtdwnKbNffKhzP9w8ztv52Wjj6ifiddHB1Ntw6FK+We/XF4oQOhJtgZID+n9JE9ndo8V6LNnVSUOiO+Er25Z9iVG9B89GhtaVXSW0uw4clKKKdqvo+G7f/Z42KW2qgjShkB5YUZ594hdWj7z6LMi04KN8TQgZcYxSAeRGjjXJNaIifDhnHGQFW6tvbFM4vQcuwSk46KMs7qjo8+oRWxptSS88UeNjLRdmRFvL8CxJLTBcY6L3DckvaLLtib5q+azF8sBmQaOkSR/KXroUdAmvxuQq48B8dZqEqX5J6BrXA8cRTqaxjsLH8ntJaQ7lE9/k40eqA0nZdVGhy/Y6dtkfNCd7qRmKpzsEPWGYgMSZuKk2TaI5eKsos+38cjd2J74pctSNfOQOVCXE="
}

# Creating key-pair on AWS using SSH-public key
resource "aws_key_pair" "deployer" {
  key_name   = var.key-name
  public_key = file("${path.module}/anne-key.pub")
}