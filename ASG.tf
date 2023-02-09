resource "aws_launch_template" "ManishASG-tf-template" {
    name = "ManishASG-tf-template"
    image_id="ami-01a4f99c4ac11b03c"
    instance_type = "t2.micro"
    key_name = "nginx-key"  
    #security_group_names = aws_security_group.manishVPC-tf-pub-SG
    vpc_security_group_ids = [aws_security_group.manishVPC-tf-pub-SG.id]
    
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "ASG-tf-template"
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
    id = aws_launch_template.ManishASG-tf-template.id
  }
  vpc_zone_identifier = [aws_subnet.manishVPC-tf-pub-sub-1a.id,aws_subnet.manishVPC-tf-pub-sub-1b.id]
  tag {
    key                 = "Name"
    value               = "ManishASG-tf-pub"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "manish-ASG-ALB-attachment" {
  autoscaling_group_name = aws_autoscaling_group.ManishASG-tf-pub.id
  #elb                    = aws_elb.manishLB-tf.id
  lb_target_group_arn = aws_lb_target_group.manishLB-tf-pub-TG.arn
}