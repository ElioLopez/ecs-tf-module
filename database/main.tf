resource "aws_db_instance" "main" {
  identifier           = "${var.identifier}-${var.environment}"
  allocated_storage    = var.storage_gb
  storage_type         = "gp2"
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  name                 = "demo"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.${var.engine}${var.engine_version}"
  skip_final_snapshot  = true
  vpc_security_group_ids = var.sg_ids
}


