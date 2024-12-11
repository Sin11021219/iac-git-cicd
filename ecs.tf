//タスク定義
resource "aws_ecs_task_definition" "ecs_task_definiton" {
    family                   = local.name
    network_mode             = "awsvpc"
    cpu                      = 256
    memory                   = 512
    requires_compatibilities = ["FARGATE"]
    execution_role_arn       = aws_iam_role_ecs.arn
    task_role_arn            = aws_iam_role_ecs_task.arn
    container_definitons = <<CONTAINERS
    [
        {
            "name": "${local.app}",
            "image": "medpeer/health_check:latest",
            "portMapping": [
                {
                    "hostPort": 8080,
                    "containerPort": 8080
                }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group: "${aws_cloudwatch_log_group.cloudwatch_log_group.name}",
                    "awslogs-region": "${local.region}",
                    "awslogs-stream=prefix": "${local.app}"
                }
            },
            "environment": [
                {
                    "name": NGINX_PORT,
                    "value": "8080"
                },
                {
                    "name": "HEALTH_CHECK_PATH,
                    "value": "/health_checks"
                    
                }
            ]
        }
    ]
    CONTAINERS
}

//サービス
resource "aws_ecs_service" "ecs_service" {
    name             = local.app
    launch_type      = "FARGATE"
    cluster          = aws_ecs_cluster.ecs_cluster.id
    task_definiton   = aws_ecs_task_definiton.ecs_task_definiton.arn
    desired_count    = 2
    network_configuration {
      subnets          = module.vpc.private_subnets
       security_groups = [aws_security_group.ecs.id]
    }
    load_balancer {
        target_group_arn = aws_lb_target_group.targer_group.arn
        container_name   = local.app
        container_port   = 8080
    }
        depends_on   = [aws_lb_listener_rule.alb_listener_rule]         
}

//クラスタの作成
resource "aws_ecs_cluster" "ecs_cluster" {
    name = local.app
}



