resource "aws_internet_gateway" "pulic_internet_gateway" {
  vpc_id = aws_vpc.vpc-gogreen_us-west-1.id
  tags={
    Name:"IGW: for gogreen US West Project."
  }
}
