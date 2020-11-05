variable "name" {
  type        = string
  description = "The name of the load balancer"
}

variable "subnet_ids" {
  type        = list
  description = "list of subnets used"
}

variable "vpc_id" {
  type        = string
  description = "VPC which the ALB will be bounded to"
}

variable "environment" {
  type        = string
  description = "environment where the LB will be used"
}

variable "container_port" {
  type        = number
  description = "port exposd by the container"
}

output "listener_arn" {
  value = aws_lb_listener.listener.arn
}


output "blue_target_group" {
  value = aws_lb_target_group.blue
}

output "green_target_group" {
  value = aws_lb_target_group.green

}

output "security_group" {
  value = aws_security_group.main.id
}

output "dns_address" {
  value = aws_lb.main.dns_name
}




