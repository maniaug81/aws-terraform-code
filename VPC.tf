resource "aws_vpc" "CFIVPC-tf" {
  cidr_block = var.vpccidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.vpcname
    Project = "CFI"
  }
}

resource "aws_internet_gateway" "CFIVPC-tf-igw" {
  vpc_id = aws_vpc.CFIVPC-tf.id

  tags = {
    Name = "CFIVPC-tf-igw"
    Project = "CFI"
  }
}

resource "aws_subnet" "CFIVPC-tf-pub-sub-1a" {
  vpc_id     = aws_vpc.CFIVPC-tf.id
  cidr_block = var.subnet1cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "CFIVPC-tf-pub-sub-1a"
    Project = "CFI"
  }
}

resource "aws_subnet" "CFIVPC-tf-pub-sub-1b" {
  vpc_id     = aws_vpc.CFIVPC-tf.id
  cidr_block = var.subnet2cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "CFIVPC-tf-pub-sub-1b"
    Project = "CFI"
  }
}

resource "aws_route_table" "CFIVPC-tf-pub-rt" {
  vpc_id = aws_vpc.CFIVPC-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.CFIVPC-tf-igw.id
  }
  tags = {
    Name = "CFIVPC-tf-pub-rt"
    Project = "CFI"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.CFIVPC-tf-pub-sub-1a.id
  route_table_id = aws_route_table.CFIVPC-tf-pub-rt.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.CFIVPC-tf-pub-sub-1b.id
  route_table_id = aws_route_table.CFIVPC-tf-pub-rt.id
}

 
