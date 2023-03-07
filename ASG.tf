resource "aws_launch_template" "ManishASG-tf-template-pub" {
    name = "ManishASG-tf-template-pub"
    image_id=var.image-id
    instance_type = "t2.micro"
    key_name = var.key-pair-name  
    #security_group_names = aws_security_group.manishVPC-tf-pub-SG
    vpc_security_group_ids = [aws_security_group.manishVPC-tf-pub-SG.id]
    
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "ManishASG-tf-template-pub"
        Project = "test-tf"        
      }
  }
  user_data = filebase64("${path.module}/user_data.txt")
}
resource "aws_autoscaling_group" "ManishASG-tf-pub" {
  name = "ManishASG-tf-pub"
  max_size = 1
  min_size = 1
  desired_capacity = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  launch_template {
    id = aws_launch_template.ManishASG-tf-template-pub.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.manishVPC-tf-pub-sub-1a.id,aws_subnet.manishVPC-tf-pub-sub-1b.id]
  tag {
    key                 = "Name"
    value               = "ManishASG-tf-pub"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "manish-ASG-ALB-attachment-pub" {
  autoscaling_group_name = aws_autoscaling_group.ManishASG-tf-pub.id
  #elb                    = aws_elb.manishLB-tf.id
  lb_target_group_arn = aws_lb_target_group.manishLB-tf-pub-TG.arn
}

resource "aws_launch_template" "ManishASG-tf-template-priv" {
    name = "ManishASG-tf-template-priv"
    image_id=var.image-id
    instance_type = "t2.micro"
    key_name = var.key-pair-name
    #security_group_names = aws_security_group.manishVPC-tf-priv-SG
    vpc_security_group_ids = [aws_security_group.manishVPC-tf-priv-SG.id]
    
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "ManishASG-tf-template-priv"
        Project = "test-tf"        
      }
  }
  #user_data = filebase64("${path.module}/user_data.txt")
}
resource "aws_autoscaling_group" "ManishASG-tf-priv" {
  name = "ManishASG-tf-priv"
  max_size = 1
  min_size = 1
  desired_capacity = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  launch_template {
    id = aws_launch_template.ManishASG-tf-template-priv.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.manishVPC-tf-priv-sub-1a.id,aws_subnet.manishVPC-tf-priv-sub-1b.id]
  tag {
    key                 = "Name"
    value               = "ManishASG-tf-priv"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "manish-ASG-ALB-attachment-priv" {
  autoscaling_group_name = aws_autoscaling_group.ManishASG-tf-priv.id
  #elb                    = aws_elb.manishLB-tf.id
  lb_target_group_arn = aws_lb_target_group.manishLB-tf-priv-TG.arn
}