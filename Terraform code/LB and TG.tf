resource "aws_lb" "main" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-12345678"]
  subnets            = ["subnet-12345678", "subnet-87654321"]
}

resource "aws_lb_target_group" "notification_api" {
  name     = "${var.app_name}-notification-api-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = "vpc-12345678"
  health_check {
    path = "/health"
    interval = 30
    timeout = 5
  }
}

resource "aws_lb_target_group" "email_sender" {
  name     = "${var.app_name}-email-sender-tg"
  port     = 3001
  protocol = "HTTP"
  vpc_id   = "vpc-12345678"
  health_check {
    path = "/health"
    interval = 30
    timeout = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notification_api.arn
  }
}

