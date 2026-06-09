terraform {
    required_providers {
      aws = {
        source = "Hashicorp/aws"
        version = "~> 6.0"
      }
      random = {
        source = "Hashicorp/random"
      }
    }
    
    backend "s3" {
      bucket = "xyzcorp-terraform--us-east-2-a"
      key = "dev/terraform.tfstate"
      region = "us-east-2"
      encrypt = true
      use_lockfile = true
    }
}