provider "aws" {
  #Virginia, USA
  region = "us-east-1"
}

resource "aws_instance" "example" {
  #Ubuntu 14.04 AMI (Amazon Machine Image)
  ami = "ami-2d39803a"
  instance_type = "t2.micro"
}