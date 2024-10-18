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
      version = "5.72.0"
    }
  }
  required_version = "~> 1.9"
}

provider "aws" {
  region = "us-west-2"
}
