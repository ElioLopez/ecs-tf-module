# ecs-tf-module

![alt text](https://github.com/ElioLopez/ecs-tf-module/blob/main/images/terraform_logo.png?raw=true)


A terraform module to put a sample java app on a ECS fargate cluster. All the required infrastructure and configuration files are automatically generated.

## This module create the following resources

* default VPC (app_name used)
* S3 bucket (app_name + "terraform-state" + environment used)
* cloudwatch (app_name used)
* ecr repo (app_name + environment used)
* ecs cluster (app_name + environment used)
* application load balancer (listeners and target groups, app_name + environment used)
* ALB security group
* roles (app_name + environment used)
* ecs service (app_name used)
* ecs task definition(app_name used)
* ecs security group
* code deploy app (deployment group, app_name + environment used)
* rds database (app_name + environment used))

configuration files created:

* appspec.yaml
* task definition json file (app_name used)
* github actions workflow file

## Input variables

* app_name
* port, memory and CPU used by the container
* region
* environment
* expects a Dockerfile of the app to be built on root directory
* database parameters

## Outputs

* lb_address where the app will be available
* db_endpoint to be used on app config
* bucket_name for the remote backend

## Usage

``` bash
module "ecs_app" {
  source = "git@github.com:freenet-group/ecs-tf-module.git?ref=v0.2.5-dev"

  app_name      = "test-app-dpvo"
  region        = "eu-central-1"
  environment   = "dev"

  dockerfile    = "Dockerfile" #Docker file used by the github action to build the image
  container = {
    port = 8080
    memory = 1024
    cpu = 512
  }

  database = {
    name = "demo"
    username  = "demo_user"
    password  = "demo_pass"     #this one can be later changed on AWS console
    engine = "mysql"
    version = "5.6"
    instance_class = "db.t2.micro"
    storage = 20
  }
}
```

and for the outputs:

``` hcl
output lb_adress {
  value = module.ecs_app.lb_address
}

output s3_bucket {
  value = module.ecs_app.bucket_name
}

output database_endpoint {
  value = module.ecs_app.database_endpoint
}
```

Note: the project should be run locally first, so all the AWS resources and configuration files are created, then you can enable the remote backend like so:

``` hcl
terraform {
  backend "s3" {
    bucket = "test-app-dpvo-terraform-state-dev"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    profile = "workshop_dpvo_user"
  }
}
```

And then push all the files to your repo.
For a working example using this module you can check [this one](https://github.com/freenet-group/dpvo-ecs-tf-sample).
