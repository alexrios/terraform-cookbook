provider "aws" {
  #Virginia, USA
  region = "us-east-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

resource "aws_instance" "example" {
  #Ubuntu 14.04 AMI (Amazon Machine Image)
  ami = "ami-2d39803a"
  instance_type = "t2.micro"

  #The “<<-EOF” and “EOF” are Terraform’s heredoc syntax,
  #which allows you to create multiline strings without having to put “\n”
  #all over the place
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  #Mandatory to associate the aws_security_group with instance
  vpc_security_group_ids = [
    "${aws_security_group.instance.id}"]
  tags {
    Name = "My Instance Name"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

# Outputs the public IP of AWS instace created
output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}