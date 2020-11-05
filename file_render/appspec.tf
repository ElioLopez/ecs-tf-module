#rendering json definition task for github
locals {
    appspec_rendered_content = templatefile(".terraform/modules/ecs_app/file_render/appspec.tmpl",
      {
        container_name  = var.name
        container_port  = var.container["port"]
         })
}

resource "null_resource" "local_appspec" {
  triggers = {
    template = local.appspec_rendered_content
  }

 # Render to local file on machine
 # https://github.com/hashicorp/terraform/issues/8090#issuecomment-291823613
  provisioner "local-exec" {
    command = format(
      "cat <<\"EOF\" > \"%s\"\n%s\nEOF",
      "appspec.yml",
      local.appspec_rendered_content
    )
  }
}



