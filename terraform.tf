terraform {
  /*/
  backend "s3" {
    bucket = "import-terraform-state-aey"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-2"

    dynamodb_table = "import-terraform-state-locks"
    encrypt        = true
  }
  /*/
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.0"
      #version = "~> 4.46.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source = "hashicorp/tls"
      #version = "~> 4.0.4"
      version = "~> 4.0.6"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
      #version = "~> 2.3.5"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.1"
      #version = "~> 2.33.0"
    }

  }
  #required_version = "~> 1.3"
  required_version = "~> 1.9"
}

provider "aws" {
  region = var.region
}

provider "tls" {
  # Configuration options
}
