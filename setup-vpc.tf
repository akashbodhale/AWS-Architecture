resource "aws_vpc" "vpc-gogreen_us-west-1"{
    cidr_block= var.vpc_cidr
    tags={
        Name="VPC: vpc-gogreen_us-west-1"
    }
}