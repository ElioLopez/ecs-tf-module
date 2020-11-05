

module "vpc" {
  source        = "./vpc"
  name          = var.app_name
  region        = var.region
}

module "s3_bucket" {
  source        = "./s3_bucket"
  name          = "${var.app_name}-terraform-state-${var.environment}"
}

module "alb" {
  source         = "./alb"
  name           = var.app_name
  environment    = var.environment
  subnet_ids     = module.vpc.subnet_ids
  vpc_id         = module.vpc.vpc_id
  container_port = var.container["port"]
}

module "file_render" {
  source         = "./file_render"
  name           = var.app_name
  execution_role = aws_iam_role.ecsTaskExecutionRole.arn
  dockerfile     = var.dockerfile
  container = {
      port = 8080
      memory = 1024
      cpu = 512
    }
  region          = var.region
  log_group       = aws_cloudwatch_log_group.main.name
  ecr_repository  = aws_ecr_repository.main.name
  service_name    = "service-${var.app_name}"
  cluster_name    = aws_ecs_cluster.main.name
  code_deploy_app = var.app_name
  code_deploy_group = "${var.app_name}-${var.environment}"
}

module "code_deploy" {
  source             = "./code_deploy"
  name               = var.app_name
  cluster_name       = aws_ecs_cluster.main.name
  service_name       = module.ecs_service.service_name
  service_role_arn   = aws_iam_role.codedeploy_service.arn
  listener_arns      = [module.alb.listener_arn]
  deployment_group   = "${var.app_name}-${var.environment}"
  blue_target_group  = module.alb.blue_target_group.name
  green_target_group = module.alb.green_target_group.name
}

module "ecs_service" {
  source               = "./ecs_service"
  name                 = "service-${var.app_name}"
  cluster_name         = aws_ecs_cluster.main.name
  subnet_ids           = module.vpc.subnet_ids
  target_group_arn     = module.alb.green_target_group.arn
  lb_sg_id             = module.alb.security_group
  cidr_block_db        = module.vpc.cidr_block
  container_port       = var.container["port"]
  container_name       = var.app_name
  task_definition      = module.ecs_task_definition.arn
  environment          = var.environment
  }

module "ecs_task_definition" {
  source               = "./ecs_task_definition"
  name                 = var.app_name
  container_port       = var.container["port"]
  container_name       = var.app_name
  container_memory     = var.container["memory"]
  container_cpu        = var.container["cpu"]
  execution_role_arn   = aws_iam_role.ecsTaskExecutionRole.arn
  log_region           = var.region
  log_group            = aws_cloudwatch_log_group.main.name
  }


module "database" {
  source          = "./database"
  name            = var.database["name"]
  identifier      = var.app_name
  engine          = var.database["engine"]
  engine_version  = var.database["version"]
  storage_gb      = var.database["storage"]
  instance_class  = var.database["instance_class"]
  username        = var.database["username"]
  password        = var.database["password"]
  environment     = var.environment
  sg_ids          = [ module.ecs_service.security_group, ]
}
