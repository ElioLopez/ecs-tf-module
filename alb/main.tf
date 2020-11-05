resource "aws_lb" "main" {
  name            = "${var.name}-lb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.main.id]
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.main.arn # Referencing our load balancer
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn # Referencing our target group
  }

#this lyfecicle rule should be added to not change the target group every time we apply
  lifecycle {
    ignore_changes         = [default_action]
  }
}

resource "aws_lb_target_group" "blue" {
  name        = "${var.name}-blue-tg-${var.environment}"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  deregistration_delay  = 30
  slow_start = 30
  vpc_id      = var.vpc_id # Referencing the default VPC

  health_check {
    interval = 15
    healthy_threshold = 2
    matcher = "200,301,302"
    path = "/"
  }
}

resource "aws_lb_target_group" "green" {
  name        = "${var.name}-green-tg-${var.environment}"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  deregistration_delay  = 30
  slow_start = 30
  vpc_id      = var.vpc_id # Referencing the default VPC

  health_check {
    interval = 15
    healthy_threshold = 2
    matcher = "200,301,302"
    path = "/"
  }
}

