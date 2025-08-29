resource "aws_lb" "app_lb" {
    name="go-green-lb"
    load_balancer_type = "application"
    internal = false
    security_groups = [aws_security_group.sg_ig_lb.id]
    subnets = [aws_subnet.aws_gogreen_public_subnets[*].id]
    depends_on = [aws_internet_gateway.pulic_internet_gateway]
}

resource "aws_lb_target_group" "alb_ec2_tg" {
  name     = "go-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-gogreen_us-west-1
  tags = {
    Name = "go-green_tg"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  tags = {
    Name = "go-green-listener"
  }
}

