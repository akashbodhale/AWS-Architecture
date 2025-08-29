resource "aws_launch_template" "web-tier-ec2-asg-tp" {
  name = "web-tier-ec2"

  image_id      = "ami-0e40cbc388241f8ce" 
  instance_type = "M6.large"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.sg_web_tier]
  }
  
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_s3_profile.name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-tier-ec2-server"
    }
  }
}

resource "aws_launch_template" "app-tier-ec2-asg-tp" {
  name = "app-tier-ec2"

  image_id      = "ami-0e40cbc388241f8ce" 
  instance_type = "M6.2xlarge"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.sg_app_tier]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_s3_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-tier-ec2-server"
    }
  }
}

# AutoScaling Group for WEB (Public Subnet)
resource "aws_autoscaling_group" "web_tier_asg" {
  name                = "web-tier-asg"
  desired_capacity    = 3
  min_size            = 3
  max_size            = 6
  target_group_arns   = [aws_lb_target_group.alb_ec2_tg.arn]
  vpc_zone_identifier = aws_subnet.aws_gogreen_public_subnets[*].id

  launch_template {
    id      = aws_launch_template.web-tier-ec2-asg-tp.id
    version = "$Latest"
  }

  health_check_type = "EC2"
}

# AutoScaling Group for APP (Private Subnet)
resource "aws_autoscaling_group" "app_tier_asg" {
  name                = "app-tier-asg"
  desired_capacity    = 3
  min_size            = 3
  max_size            = 6

  vpc_zone_identifier = aws_subnet.aws_gogreen_private_subnets[*].id

  launch_template {
    id      = aws_launch_template.app-tier-ec2-asg-tp.id
    version = "$Latest"
  }

  health_check_type = "EC2"
}