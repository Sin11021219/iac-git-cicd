resource "aws_lb" "alb" {
    name               = "${local.app}-alb"
    load_balancer_type = "application"
    security_group     = [aws_security_group.alb.id]
    subnets            = module.vpc.public_subnets

}

resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = 80
    protocpl          = "HTTP"

    default_action {
        type = "fixed-response"

     fixed_responce {
        content_type = "text/plain"
        message_body = "Fixed response content"
        status_code  = "200"
     }
  }
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
    listener_arn = aws_lb_listener.alb_listener.arn
    
    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.target_group.arn 
    }

    conditon {
        path_pattern {
            values = ["*"]
        }
    }
}

resource "aws_lb_target_group" "target_group" {
    name        = "${local.app}-target-group"
    port        = 8080
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id   = module.vpc.vpc_id

 health_check {
    healthy_threshold = 3
    interval          = 30
    path              = "/health_checks"
    protpcol          = "HTTP"
    timeout           = 5
 }
}



