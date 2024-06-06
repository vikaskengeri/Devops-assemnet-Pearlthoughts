resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "notification_api" {
  family                   = "notification-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "notification-api"
      image     = "<account-id>.dkr.ecr.us-est-1.amazonaws.com/notification-api:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = []
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/notification-api"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "email_sender" {
  family                   = "email-sender"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "email-sender"
      image     = "<account-id>.dkr.ecr.us-east-1.amazonaws.com/email-sender:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
        }
      ]
      environment = []
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/email-sender"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "notification_api" {
  name            = "notification-api"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.notification_api.arn
  desired_count   = 2

  launch_type = "FARGATE"

  network_configuration {
    subnets         = ["subnet-12345678", "subnet-87654321"]
    security_groups = ["sg-12345678"]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.notification_api.arn
    container_name   = "notification-api"
    container_port   = 3000
  }
}

resource "aws_ecs_service" "email_sender" {
  name            = "email-sender"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.email_sender.arn
  desired_count   = 2

  launch_type = "FARGATE"

  network_configuration {
    subnets         = ["subnet-12345678", "subnet-87654321"]
    security_groups = ["sg-12345678"]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.email_sender.arn
    container_name   = "email-sender"
    container_port   = 3001
  }
}


