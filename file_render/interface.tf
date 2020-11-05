variable "name" {
  type        = string
  description = "Name used for render"
}

variable "execution_role" {
  type        = string
  description = "execution role used in the render"
}

variable "region" {
  type        = string
  description = "log region used in the render"
}

variable "log_group" {
  type        = string
  description = "log group used in the render"
}

variable "container" {
  type        = map(number)
  description = "parameters map for container"
}

variable "ecr_repository" {
  type        = string
  description = "ecr repo used"
}

variable "service_name" {
  type        = string
  description = "service name to fill in the ECS task definition"
}

variable "cluster_name" {
  type        = string
  description = "cluster name to fill in the ECS task definition"
}

variable "code_deploy_app" {
  type        = string
  description = "Application name to fill in the ECS task definition"
}

variable "code_deploy_group" {
  type        = string
  description = "deployment group name to fill in the ECS task definition"
}

variable "dockerfile" {
  type        = string
  description = "dockerfile used in the github action"
}
