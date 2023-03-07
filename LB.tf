resource "aws_alb" "manishLB-tf-pub" {
  name = "manishLB-tf-pub"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.manishVPC-tf-pub-SG.id]
  subnets = [aws_subnet.manishVPC-tf-pub-sub-1b.id,aws_subnet.manishVPC-tf-pub-sub-1a.id]
  tags = {
    Name = "pub-LB-tf"
    Project = "test-tf"        
  }
}
resource "aws_lb_target_group" "manishLB-tf-pub-TG" {
  name = "manishLB-tf-pub-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.manishVPC-tf.id
  tags = {
    Name = "pub-LB-TG-tf"
    Project = "test-tf"        
  }
}
# Attach the target group to the ALB
resource "aws_alb_listener" "manishALB-tf-listner-pub" {
  load_balancer_arn = aws_alb.manishLB-tf-pub.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.manishLB-tf-pub-TG.arn
    type = "forward"
  }
  tags = {
    Name = "pub-LB-listener-tf"
    Project = "test-tf"        
  }
}

resource "aws_alb" "manishLB-tf-priv" {
  name = "manishLB-tf-priv"
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.manishVPC-tf-priv-SG.id]
  subnets = [aws_subnet.manishVPC-tf-priv-sub-1b.id,aws_subnet.manishVPC-tf-priv-sub-1a.id]
  tags = {
    Name = "priv-LB-tf"
    Project = "test-tf"        
  }
}
resource "aws_lb_target_group" "manishLB-tf-priv-TG" {
  name = "manishLB-tf-priv-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.manishVPC-tf.id
  tags = {
    Name = "priv-LB-TG-tf"
    Project = "test-tf"        
  }
}
# Attach the target group to the ALB
resource "aws_alb_listener" "manishALB-tf-listner-priv" {
  load_balancer_arn = aws_alb.manishLB-tf-priv.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.manishLB-tf-priv-TG.arn
    type = "forward"
  }
  tags = {
    Name = "priv-LB-listener-tf"
    Project = "test-tf"        
  }
}
