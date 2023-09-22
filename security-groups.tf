resource "aws_security_group" "CFIVPC-tf-pub-SG" {
  name        = "CFIVPC-tf-pub-SG"
  description = "Allow internet access"
  vpc_id      = aws_vpc.CFIVPC-tf.id

  tags = {
    Name = "CFI-vpc-tf-SG-Bastion"
    Project = "test-tf"        
  }
}
resource "aws_security_group_rule" "ssh_inbound" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CFIVPC-tf-pub-SG.id
}
resource "aws_security_group_rule" "http_inbound" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CFIVPC-tf-pub-SG.id
}

resource "aws_security_group_rule" "https_inbound" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CFIVPC-tf-pub-SG.id
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.CFIVPC-tf-pub-SG.id
}
