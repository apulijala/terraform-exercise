resource "aws_lb_target_group" "front_end" {

  name        = "alb-asg-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id


}



resource "aws_security_group" "lb_sg" {
  vpc_id = var.vpc_id # aws_vpc.vpc.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    "Name" = "LoadBalancerSecurityGroup"
  }
}

resource "aws_lb" "my_alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }

  condition {
    path_pattern {
      values = ["*/*"]
    }
  }

}


resource "aws_instance" "bastion" {
  ami =   var.ami_id # "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  key_name = "exercise"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  tags = {
    "Name" = "BastionHost"
  }
}





