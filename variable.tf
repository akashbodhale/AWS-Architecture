variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
  default     = "10.0.0.0/16"
#   10.0.0.0 - 10.0.255.255
}

variable "us_availability_zone" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-west-1a", "us-west-1b"]
}

variable "cidr_public_subnet"{
    type=list(string)
    description="Public Subnet CIDR values"
    default = [ "10.0.1.0/24","10.0.3.0/24"]
    # 10.0.1.0 - 10.0.1.255
    # 10.0.3.0 - 10.0.3.255
    # 10.0.5.0 - 10.0.5.255
}

variable "cidr_private_subnet"{
    type=list(string)
    description="Private Subnet CIDR values"
    default = [ "10.0.5.0/24","10.0.7.0/24","10.0.9.0/24","10.0.11.0/24"]
    # 10.0.5.0 - 10.0.5.255
    # 10.0.7.0 - 10.0.7.255
    # 10.0.9.0 - 10.0.9.255
    # 10.0.11.0 - 10.0.11.255
}
variable "gogreen-s3"{
  type = string
  description = "go green bucket"
}