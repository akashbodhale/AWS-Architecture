resource "aws_route_table" "gogreen_public_route_table" {
    vpc_id = aws_vpc.vpc-gogreen_us-west-1
    route = {
        cidr_block="0.0.0.0/0"
        gateway_id = aws_internet_gateway.pulic_internet_gateway.id
    }
    tags={
        Name: "RT Public: For gogreen US West Project."
    }
}
resource "aws_route_table" "gogreen_private_route_table" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.vpc-gogreen_us-west-1
  depends_on = [ aws_nat_gateway.nat_gateway ]
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
  tags={
        Name: "RT Private: For gogreen US West Project."
    }
}