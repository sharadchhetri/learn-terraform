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
    
    ## Read the README file for running terraform init command with backend configuration file
    backend "s3" {
      encrypt = true
      use_lockfile = true
    }
}