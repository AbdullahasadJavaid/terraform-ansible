terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # Mumbai
}


# Security Group

resource "aws_security_group" "ansible_sg" {
  name        = "ansible-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "testing-ansible"
  }
}


# EC2 Instances (2)

resource "aws_instance" "ansible_ec2" {
  count         = 2
  ami           = "ami-03f4878755434977f" # Amazon Linux 2 (Free Tier – Mumbai)
  instance_type = "t3.micro"
  key_name      = "key_name"

  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = {
    Name = "test-ansible-${count.index + 1}"
  }
}


# Outputs

output "instance_public_ips" {
  value = aws_instance.ansible_ec2[*].public_ip
}
