variable "name" {
  type        = string
  description = "The name of the VPC."
}

variable "region" {
  type        = string
  description = "region where the VPC will be created"
}

output "subnet_ids" {
  value = [aws_default_subnet.default_subnet_a.id, aws_default_subnet.default_subnet_b.id, aws_default_subnet.default_subnet_c.id ]
}

output "vpc_id" {
  value = aws_default_vpc.default_vpc.id
}

output "cidr_block" {
  value = aws_default_vpc.default_vpc.cidr_block
}


