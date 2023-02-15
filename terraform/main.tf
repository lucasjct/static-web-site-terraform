provider "aws" {

  region = "us-east-1"

}

terraform {
  required_version = "v1.3.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.1"
    }
  }

  backend "s3" {

    bucket = "aws-linux-tips"
    key    = "terraform-test.tfstate"
    region = "us-east-1"

  }
}

data "aws_caller_identity" "current" {

}

resource "random_pet" "bucket_name" {

  prefix = data.aws_caller_identity.current.account_id
  length = 4

}



