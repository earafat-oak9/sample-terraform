terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  profile = "sandbox-rw"
  region = "us-east-2"
}

# module "s3" {
#   source = "./s3/"
# }

module "elastiCache" {
  source = "./elastiCache"
}
