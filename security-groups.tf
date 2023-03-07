resource "aws_security_group" "manishVPC-tf-pub-SG" {
  name        = "manishVPC-tf-pub-SG"
  description = "Allow internet access"
  vpc_id      = aws_vpc.manishVPC-tf.id

  tags = {
    Name = "manishVPC-tf-pub-SG"
    Project = "test-tf"        
  }
}
resource "aws_security_group_rule" "ssh_inbound" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.manishVPC-tf-pub-SG.id
}
resource "aws_security_group_rule" "http_inbound" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.manishVPC-tf-pub-SG.id
}

resource "aws_security_group_rule" "https_inbound" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.manishVPC-tf-pub-SG.id
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.manishVPC-tf-pub-SG.id
}

resource "aws_security_group" "manishVPC-tf-priv-SG" {
  name        = "manishVPC-tf-priv-SG"
  description = "Allow access from load balancer only"
  vpc_id      = aws_vpc.manishVPC-tf.id

  tags = {
    Name = "manish-vpc-tf-SG-for-app"
    Project = "test-tf"        
  }
}
resource "aws_security_group" "manishVPC-tf-rds-SG" {
  name        = "manishVPC-tf-rds-SG"
  description = "Allow access to app vms only to rds"
  vpc_id      = aws_vpc.manishVPC-tf.id

  tags = {
    Name = "manish-vpc-tf-SG-for-rds"
    Project = "test-tf"        
  }
}