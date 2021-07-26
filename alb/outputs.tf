output "alb_sec_grp_id" {
  value = aws_security_group.lb_sg.id
}

output "alb_target_group_id" {
  value = aws_lb_target_group.front_end.arn
}

output "alb_url" {
  value = aws_lb.my_alb.dns_name
}