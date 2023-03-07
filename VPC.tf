resource "aws_vpc" "manishVPC-tf" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "manishVPC-tf"
    Project = "test-tf"
  }
}


resource "aws_internet_gateway" "manishVPC-tf-igw" {
  vpc_id = aws_vpc.manishVPC-tf.id

  tags = {
    Name = "manishVPC-tf-igw"
    Project = "test-tf"
  }
}

resource "aws_subnet" "manishVPC-tf-pub-sub-1a" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.1.0/24"
  availability_zone = var.az1a
  map_public_ip_on_launch = true

  tags = {
    Name = "manishVPC-tf-pub-sub-1a"
    Project = "test-tf"    
  }
}

resource "aws_subnet" "manishVPC-tf-pub-sub-1b" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.2.0/24"
  availability_zone = var.az1b
  map_public_ip_on_launch = true

  tags = {
    Name = "manishVPC-tf-pub-sub-1b"
    Project = "test-tf"    
  }
}
resource "aws_subnet" "manishVPC-tf-priv-sub-1a" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.3.0/24"
  availability_zone = var.az1a

  tags = {
    Name = "manishVPC-tf-priv-sub-1a"
    Project = "test-tf"    
  }
}

resource "aws_subnet" "manishVPC-tf-priv-sub-1b" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.4.0/24"
  availability_zone = var.az1b

  tags = {
    Name = "manishVPC-tf-priv-sub-1b"
    Project = "test-tf"    
  }
}
resource "aws_subnet" "manishVPC-tf-rds-sub-1a" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.5.0/24"
  availability_zone = var.az1a

  tags = {
    Name = "manishVPC-tf-rds-sub-1a"
    Project = "test-tf"    
  }
}

resource "aws_subnet" "manishVPC-tf-rds-sub-1b" {
  vpc_id     = aws_vpc.manishVPC-tf.id
  cidr_block = "192.168.6.0/24"
  availability_zone = var.az1b

  tags = {
    Name = "manishVPC-tf-rds-sub-1b"
    Project = "test-tf"    
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
    Project = "test-tf"    
  }
}

resource "aws_route_table" "manishVPC-tf-priv-rt" {
  vpc_id = aws_vpc.manishVPC-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.manishVPC-tf-nat-gw.id
  }

  tags = {
    Name = "manishVPC-tf-priv-rt"
    Project = "test-tf"    
  }
}
resource "aws_route_table" "manishVPC-tf-rds-rt" {
  vpc_id = aws_vpc.manishVPC-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.manishVPC-tf-nat-gw.id
  }

  tags = {
    Name = "manishVPC-tf-rds-rt"
    Project = "test-tf"    
  }
}

resource "aws_route_table_association" "pub_sub_a" {
  subnet_id      = aws_subnet.manishVPC-tf-pub-sub-1a.id
  route_table_id = aws_route_table.manishVPC-tf-pub-rt.id
}
resource "aws_route_table_association" "pub_sub_b" {
  subnet_id      = aws_subnet.manishVPC-tf-pub-sub-1b.id
  route_table_id = aws_route_table.manishVPC-tf-pub-rt.id
}

resource "aws_route_table_association" "priv_sub_a" {
  subnet_id      = aws_subnet.manishVPC-tf-priv-sub-1a.id
  route_table_id = aws_route_table.manishVPC-tf-priv-rt.id
}
resource "aws_route_table_association" "priv_sub_b" {
  subnet_id      = aws_subnet.manishVPC-tf-priv-sub-1b.id
  route_table_id = aws_route_table.manishVPC-tf-priv-rt.id
}
resource "aws_route_table_association" "rds_sub_a" {
  subnet_id      = aws_subnet.manishVPC-tf-rds-sub-1a.id
  route_table_id = aws_route_table.manishVPC-tf-rds-rt.id
}
resource "aws_route_table_association" "rds_sub_b" {
  subnet_id      = aws_subnet.manishVPC-tf-rds-sub-1b.id
  route_table_id = aws_route_table.manishVPC-tf-rds-rt.id
}
resource "aws_eip" "manishVPC-tf-nat-gw-eip" {
  vpc = true
}
resource "aws_nat_gateway" "manishVPC-tf-nat-gw" {
  allocation_id = aws_eip.manishVPC-tf-nat-gw-eip.id
  subnet_id = aws_subnet.manishVPC-tf-pub-sub-1a.id
  tags = {
    "Name" = "manishVPC-tf-nat-gw"
  }
}