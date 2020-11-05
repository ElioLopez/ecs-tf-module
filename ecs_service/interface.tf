variable "name" {
  type        = string
  description = "Name of the ecs service"
}

variable "environment" {
  type        = string
  description = "Environment of the ecs service"
}

variable "container_name" {
  type        = string
  description = "Name of the container"
}

variable "cluster_name" {
  type        = string
  description = "Name of the ecs cluster used"
}

variable "subnet_ids" {
  type        = list
  description = "list of subnets used"
}

variable "target_group_arn" {
  type        = string
  description = "target group arn used"
}

variable "lb_sg_id" {
  type        = string
  description = "load balancer security group id"
}

variable "cidr_block_db" {
  type        = string
  description = "cidr block used in the security group for the db"
}

variable "container_port" {
  type        = number
  description = "port exposd by the container"
}

variable "task_definition" {
  type        = string
  description = "task definition ARN to spin up"
}

output "service_name" {
  value = aws_ecs_service.main.name
}

output "security_group" {
  value = aws_security_group.main.id
}

