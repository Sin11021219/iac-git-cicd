resource "aws_security_group" "alb" {
    name        = "${local.app}-alb"
    descripton  = "For ALB."
    vpc_id      = module.vpc.vpc_id
    ingress {
        description = "Allow HTTP form ALL."
        form_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [0.0.0.0/0]
     }
     egress {
         description = "Allow all to outbound."
         from_pory   = 0
         to_port     = 0
         protocol    = "-1"
         cidr_blocks = ["0.0.0./0"] 
     } 
     tags = {
        Name = "${local.app}-alb"
     }   
     
}

resource "aws_security_group" "ecs"{
    name        = "${local.name}-ecs"
    description = "For ECS."
    vpc_id      = module.vpc.vpc_id
    egress {
        description = "Allow all to outbound."
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${local.app}-ecs"
    }
}

resource "aws_security_group" "ecs_from_alb" {
    description = "Allow 8080 form Security Group for ALB. "
    type        = "ingress"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    source_security_group_id = aws_securoty_group.alb.id
    security_group_id        = aws_security_group.ecs.id
}

