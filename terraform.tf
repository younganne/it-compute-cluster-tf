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
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.6"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.5"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.33.0"
    }

  }
  required_version = "~> 1.9"
}

provider "aws" {
  region = var.region
}

provider "tls" {
  # Configuration options
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

