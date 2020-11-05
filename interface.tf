variable "app_name" {
  type        = string
  description = "The name of the app."
}

variable "region" {
  type        = string
  description = "region where the VPC will be created"
}

variable "environment" {
  type        = string
  description = "region where the VPC will be created"
}

variable "dockerfile" {
  type        = string
  description = "dockerfile used in the github action"
}

variable "database" {
  type        = map(string)
  description = "parameters map for database"
}

variable "container" {
  type        = map(number)
  description = "parameters map for container"
}

#exposing values within modules
output "execution_role" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}



