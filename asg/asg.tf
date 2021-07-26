provider "aws" {
  region = var.region
}

resource "aws_security_group" "security-group" {
  vpc_id = var.vpc_id # aws_vpc.vpc.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    security_groups = [var.sec_group]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
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
    "Name" = "AutoScalingSecurityGroup"
  }
}

resource "aws_launch_configuration" "my_launch_config" {

  name_prefix = "mylaunch"
  image_id =  var.ami_id # "ami-0dc2d3e4c0f9ebd18" #"ami-cdbfa4ab"
  instance_type = "t2.micro"
  key_name = "exercise"
  lifecycle {
    create_before_destroy = true
  }
  security_groups = [aws_security_group.security-group.id]

  user_data                   = <<EOF
#!/bin/sh
sudo amazon-linux-extras install nginx1
sudo service nginx start
EOF
}

resource "aws_autoscaling_group" "myasg" {

  name                 = "terraform-asg"
  launch_configuration = aws_launch_configuration.my_launch_config.name
  min_size             = 2
  max_size             = 4
  vpc_zone_identifier       = var.vpc_zones
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.myasg.id
  alb_target_group_arn   = var.alb_target_group_arn
}