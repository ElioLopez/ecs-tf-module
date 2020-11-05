resource "aws_ecs_task_definition" "main" {
  family        = "${var.name}-task-def"
  container_definitions    = jsonencode([
    {
      "name": "${var.container_name}",
      "image": "httpd:2.4",
      "logConfiguration": {
         "logDriver": "awslogs",
         "options": {
           "awslogs-group": "${var.log_group}",
           "awslogs-region": "${var.log_region}",
           "awslogs-stream-prefix": "ecs"
        }
      },
      "portMappings": [
        {
          "containerPort": "${var.container_port}",
          "hostPort": "${var.container_port}",
          "protocol": "tcp"
         }
           ],
         "essential": true,
         "entryPoint": [],
         "command": []
         }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  memory                   = var.container_memory      # Specifying the memory our container requires
  cpu                      = var.container_cpu         # Specifying the CPU our container requires
  execution_role_arn       = var.execution_role_arn
}
