variable "name" {
  type        = string
  description = "Name of the ecs service"
}

variable "execution_role_arn" {
  type        = string
  description = "execution role used for the task"
}

variable "container_name" {
  type        = string
  description = "Name of the container"
}

variable "container_port" {
  type        = number
  description = "port exposd by the container"
}

variable "container_memory" {
  type        = number
  description = "memory assigned to container"
}

variable "container_cpu" {
  type        = number
  description = "cpu assigned to container"
}

variable "log_region" {
  type        = string
  description = "cloudwatch logs region"
}

variable "log_group" {
  type        = string
  description = "cloudwatch log group"
}

output "arn" {
  value = aws_ecs_task_definition.main.arn
}



