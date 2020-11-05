# Deployment group's ECS service must be configured for a CODE_DEPLOY deployment controller.

resource "aws_ecs_service" "main" {
  name = var.name                         # Naming our first service
  cluster         = var.cluster_name       # Referencing our created Cluster
  task_definition = var.task_definition  # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 1 # Setting the number of containers we want deployed to 3

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true # Providing our containers with public IPs
    security_groups  = [aws_security_group.main.id]
  }

load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

#this lyfecicle rule should be added to not change the target group every time we apply

lifecycle {
    ignore_changes = [
      load_balancer,
      task_definition,
       desired_count
    ]
  }

#  depends_on = [aws_lb_listener.listener]
}


