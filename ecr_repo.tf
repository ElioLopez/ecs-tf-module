resource "aws_ecr_repository" "main" {
  name = "${var.app_name}-repo-${var.environment}"
}
