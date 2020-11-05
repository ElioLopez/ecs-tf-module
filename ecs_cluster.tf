resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster-${var.environment}" # Naming the cluster

 setting {
        name  = "containerInsights"
        value = "enabled"
    }
}

