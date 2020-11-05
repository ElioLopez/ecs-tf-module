#     CodeDeploy config section
resource "aws_codedeploy_app" "main" {
  compute_platform = "ECS"
  name = var.name
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name              = aws_codedeploy_app.main.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name = var.deployment_group
  service_role_arn      = var.service_role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT" #[CONTINUE_DEPLOYMENT STOP_DEPLOYMENT]
      wait_time_in_minutes = 0
      }
#    green_fleet_provisioning_option {
#        action = "DISCOVER_EXISTING" # [DISCOVER_EXISTING COPY_AUTO_SCALING_GROUP]
#      }
    terminate_blue_instances_on_deployment_success {
       action  = "TERMINATE" #[TERMINATE KEEP_ALIVE]
       termination_wait_time_in_minutes = 5
      }
      }

   deployment_style {
     deployment_option = "WITH_TRAFFIC_CONTROL"
     deployment_type   = "BLUE_GREEN"
   }

ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }


 load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = var.listener_arns
      }

      target_group {
        name = var.blue_target_group
      }

      target_group {
        name = var.green_target_group
      }
    }
  }


}
