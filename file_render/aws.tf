
#rendering json definition task for github
locals {
    aws_rendered_content = templatefile(".terraform/modules/ecs_app/file_render/aws.tmpl",
      {
         ecr_repository        = var.ecr_repository
         task_definition_file  = "${var.name}-td.json"
         container_name        = var.name
         region                = var.region
         service_name          = var.service_name
         cluster_name          = var.cluster_name
         code_deploy_app       = var.code_deploy_app
         code_deploy_group     = var.code_deploy_group
         docker_file           = var.dockerfile
      })
}

resource "null_resource" "local_aws" {
  triggers = {
    template = local.aws_rendered_content
  }

 # Render to local file on machine
 # https://github.com/hashicorp/terraform/issues/8090#issuecomment-291823613
  provisioner "local-exec" {

    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "aws.yml",
      local.aws_rendered_content
    )
  }
}

#replace secrets and variable needed by github actions
resource "null_resource" "local_github" {

  provisioner "local-exec" {
    command =  ".terraform/modules/ecs_app/./github_replace.sh"
  }

 depends_on = [
    null_resource.local_aws,
  ]

}

