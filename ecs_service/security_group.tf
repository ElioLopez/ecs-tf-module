resource "aws_security_group" "main" {
  name = "${var.name}-ecs_security_group-${var.environment}"

  ingress {
    from_port   = var.container_port # Allowing traffic in only from load balancer security group
    to_port     = var.container_port
    protocol    = "tcp"
#    security_groups  = [aws_security_group.workshop_lb_security_group.id]
    security_groups  = [var.lb_sg_id]
  }

  ingress {
    from_port   = 3306 # Allowing traffic in only from load balancer security group
    to_port     = 3306
    protocol    = "tcp"
#    cidr_blocks = [aws_default_vpc.default_workshop_vpc.cidr_block]
    cidr_blocks = [var.cidr_block_db]
#    cidr_blocks = ["172.31.0.0/16"] # Allow traffic to database only from within default subnets
  }

  egress {
    from_port   = 0 # Allowing any incoming port
    to_port     = 0 # Allowing any outgoing port
    protocol    = "-1" # Allowing any outgoing protocol 
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
  }
}