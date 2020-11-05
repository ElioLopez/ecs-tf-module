

#rendering json definition task for github
locals {
    our_rendered_content = templatefile(".terraform/modules/ecs_app/file_render/task_definition_json.tmpl",
      {
        execution_role  = var.execution_role
        family          = "${var.name}-task-def"
        container_name  = var.name
        log_region      = var.region
        log_group       = var.log_group
        container_port  = var.container["port"]
        container_cpu  = var.container["cpu"]
        container_memory  = var.container["memory"]
         })
}

resource "null_resource" "local" {
  triggers = {
    template = local.our_rendered_content
  }

 # Render to local file on machine
 # https://github.com/hashicorp/terraform/issues/8090#issuecomment-291823613
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "${var.name}-td.json",
      local.our_rendered_content
    )
  }
}



