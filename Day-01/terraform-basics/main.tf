terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.10"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "hardik_bucket" {
  bucket = "hardik-terraform-lab-01"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["152732246241"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "lab_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "TerraWeek-Lab-EC2"
  }
}