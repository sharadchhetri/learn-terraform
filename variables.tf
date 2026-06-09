variable "region" { type = string }
variable "vpc_cidr" {}
variable "infra_environment" { type = string }
variable "app_s3_bucket" { type = list(string)}
variable "s3_bucket_name" { type = string }
