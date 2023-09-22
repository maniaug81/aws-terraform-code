resource "aws_alb" "CFILB-tf-pub" {
  name = "CFILB-tf-pub"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.CFIVPC-tf-pub-SG.id]
  subnets = [aws_subnet.CFIVPC-tf-pub-sub-1b.id,aws_subnet.CFIVPC-tf-pub-sub-1a.id]
  tags = {
    Name = "pub-LB-tf"
    Project = "test-tf"        
  }
}
resource "aws_lb_target_group" "CFILB-tf-pub-TG" {
  name = "CFILB-tf-pub-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.CFIVPC-tf.id
  tags = {
    Name = "pub-LB-TG-tf"
    Project = "test-tf"        
  }
}
# Attach the target group to the ALB
resource "aws_alb_listener" "CFIALB-tf-listner" {
  load_balancer_arn = aws_alb.CFILB-tf-pub.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.CFILB-tf-pub-TG.arn
    type = "forward"
  }
  tags = {
    Name = "pub-LB-listener-tf"
    Project = "test-tf"        
  }
}
