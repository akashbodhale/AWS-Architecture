resource "aws_subnet" "aws_gogreen_public_subnets" {
  count=length(var.cidr_public_subnet)
  vpc_id =aws_vpc.vpc-gogreen_us-west-1
  cidr_block = element(var.cidr_public_subnet,count.index)
  availability_zone = element(var.us_availability_zone,count.index)

  tags={
    Name="Subnet-Public : Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "aws_gogreen_private_subnets" {
  count=length(var.cidr_private_subnet)
  vpc_id =aws_vpc.vpc-gogreen_us-west-1
  cidr_block = element(var.cidr_private_subnet,count.index)
  availability_zone = element(var.us_availability_zone,count.index)

  tags={
    Name="Subnet-Private : Private Subnet ${count.index + 1}"
  }
}