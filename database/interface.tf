variable "name" {
  type        = string
  description = "The name of the database"
}

variable "identifier" {
  type        = string
  description = "identifier for the database"
}

variable "environment" {
  type        = string
  description = "environment where the database will be used"
}

variable "engine" {
  type        = string
  description = "database engine used"
}

variable "instance_class" {
  type        = string
  description = "instance used for database"
}

variable "engine_version" {
  type        = string
  description = "database engine version"
}

variable "storage_gb" {
  type        = number
  description = "allocated storage for the database"
}

variable "sg_ids" {
  type        = list
  description = "list of security groups for the database"
}

variable "username" {
  type        = string
  description = "Name of the container"
}

variable "password" {
  type        = string
  description = "Name of the container"
}

output "database_endpoint" {
  value = aws_db_instance.main.endpoint
}
