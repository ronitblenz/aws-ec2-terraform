provider "aws" {
  region  = "us-east-1"
  version = "~> 2.61.0"
}

resource "aws_instance" "web" {
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  key_name      = "finalkey"

  security_groups = [aws_security_group.web.name]

  tags = {
    Name = "WebServerByTf"
  }
}

resource "aws_security_group" "web" {
  name        = "web-security-group"
  description = "Allow access to our web server"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_dns" {
  value = aws_instance.web.public_dns
}