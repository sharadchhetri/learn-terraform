output "vpc_id" {
    value = aws_vpc.vpc_infra.id
    description = "VPC ID"
}