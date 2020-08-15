# this will create ec2 instance in default vpc

variable "aws_region" {
  default     = "us-east-1"
}

variable "aws_access_key" {
}

variable "aws_secret_key" {
}

variable "key_name" {}
# Need to provide a centos based image
variable "aws_ami" {
  default = "ami-0affd4508a5d2481b"
}

# newer version for elasticsearch doesn't support t2.micro (free trier ec2 instance)
variable "aws_instance_type" {
  default     = "m3.medium"
}
