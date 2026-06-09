

# Configure the AWS provider
provider "aws" {
    region = var.region
}

resource "aws_vpc" "vpc_infra" {
  cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.infra_environment}-vpc"
        Environment = var.infra_environment
        BU = local.common_tags.BU
        TEAM = local.common_tags.TEAM
        EMAIL = local.common_tags.EMAIL
    }
}

resource "aws_subnet" "app_subnet" {
    vpc_id = aws_vpc.vpc_infra.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    tags = {
        Name = "${var.infra_environment}-subnet-app"
        Environment = var.infra_environment
        BU = local.common_tags.BU
        TEAM = local.common_tags.TEAM
        EMAIL = local.common_tags.EMAIL
    }
}

resource "aws_security_group" "sg_app" {
    name = "${var.infra_environment}-sg-app"
    description = "Security group for applications servers"
    vpc_id = aws_vpc.vpc_infra.id

     # Inbound Rules (Ingress)
    ingress {
        description = "HTTPS from anywhere"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Tomcat from anywhere"
        from_port   = 8090
        to_port     = 8090
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH from a specific IP"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["203.0.113.50/32"] # Replace with your public IP address
    }

    # Outbound Rules (Egress)
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # "-1" means all protocols
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.infra_environment}-sg-app"
        Environment = var.infra_environment
        BU = local.common_tags.BU
        TEAM = local.common_tags.TEAM
        EMAIL = local.common_tags.EMAIL
    }
}

resource "aws_s3_bucket" "app_bucket" {
    count = 2 
    bucket = var.app_s3_bucket[count.index]
    tags = {
        Name = "${var.infra_environment}-app-bucket-${count.index + 1}"
        Environment = var.infra_environment
        BU = local.common_tags.BU
        TEAM = local.common_tags.TEAM
        EMAIL = local.common_tags.EMAIL
    }
}

module "mod_s3_bucket" {
    source = "./s3_bucket"
    s3_bucket_name = var.s3_bucket_name
}