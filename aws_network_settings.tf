terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-south-1"
}

resource "aws_vpc" "manishVPC-tf" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "manishVPC-tf"
  }
}

resource "aws_internet_gateway" "manishVPC-tf-igw" {
  vpc_id = aws_vpc.manishVPC-tf.id

  tags = {
    Name = "manishVPC-tf-igw"
  }
}

resource "aws_subnet" "manishVPC-tf-pub-sub-1a" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "manishVPC-tf-pub-sub-1a"
  }
}

resource "aws_subnet" "manishVPC-tf-pub-sub-1b" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "manishVPC-tf-pub-sub-1b"
  }
}

resource "aws_route_table" "manishVPC-tf-pub-rt" {
  vpc_id = aws_vpc.manishVPC-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.manishVPC-tf-igw.id
  }
  tags = {
    Name = "manishVPC-tf-pub-rt"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.manishVPC-tf-pub-sub-1a.id
  route_table_id = aws_route_table.manishVPC-tf-pub-rt.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.manishVPC-tf-pub-sub-1b.id
  route_table_id = aws_route_table.manishVPC-tf-pub-rt.id
}

 
