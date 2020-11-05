variable "name" {
  type        = string
  description = "Name of the App."
}

variable "cluster_name" {
  type        = string
  description = "Name of the Cluster."
}

variable "service_role_arn" {
  type        = string
  description = "service role used by the app."
}

variable "listener_arns" {
  type        = list
  description = "listener arns used in the deployment group"
}

variable "green_target_group" {
  type        = string
  description = "name of the green target group"
}

variable "blue_target_group" {
  type        = string
  description = "name of the blue target group"
}

variable "deployment_group" {
  type        = string
  description = "deployment group, depends on environment"
}


variable "service_name" {
  type        = string
  description = "name of the ecs service used"
}
