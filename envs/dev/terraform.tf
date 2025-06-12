terraform {

  backend "s3" {
    bucket       = "aws-david-20-dev-s3-bucket-state"
    key          = "terraform.tfstate"
    region       = "eu-west-3"
    encrypt      = true
    #use_lockfile = true 
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}