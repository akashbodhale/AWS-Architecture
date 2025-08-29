# IGW to Load Balancer
resource "aws_security_group" "sg_ig_lb" {
  name        = "ig-lb"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc-gogreen_us-west-1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-ig-lb"
  }
}

# ALB to Web Tier
resource "aws_security_group" "sg_web_tier" {
  name        = "web-tier-sg"
  description = "Security group for web EC2s"
  vpc_id      = aws_vpc.vpc-gogreen_us-west-1.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ig_lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-tier-sg"
  }
}

# Web Tier to App Tier
resource "aws_security_group" "sg_app_tier" {
  name        = "app-tier-sg"
  description = "Security group for app EC2s"
  vpc_id      = aws_vpc.vpc-gogreen_us-west-1.id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_web_tier.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-tier-sg"
  }
}

# App Tier to DB Tier
resource "aws_security_group" "sg_db_tier" {
  name        = "db-tier-sg"
  description = "Security group for DB instances"
  vpc_id      = aws_vpc.vpc-gogreen_us-west-1.id

  ingress {
    from_port       = 3306 # assuming MySQL
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_app_tier.id]
  }

  egress {
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  security_groups = [aws_security_group.sg_app_tier.id]
}


  tags = {
    Name = "db-tier-sg"
  }
}
