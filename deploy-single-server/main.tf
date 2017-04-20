provider "aws" {
  region = "us-east-1"
  #Virginia, USA
}

resource "aws_instance" "example" {
  ami = "ami-2d39803a"
  #Ubuntu 14.04 AMI (Amazon Machine Image)
  instance_type = "t2.micro"
}