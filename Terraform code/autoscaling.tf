resource "aws_appautoscaling_target" "notification_api" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.notification_api.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "notification_api_cpu" {
  name                   = "cpu-utilization"
  policy_type            = "TargetTrackingScaling"
  resource_id            = aws_appautoscaling_target.notification_api.resource_id
  scalable_dimension     = aws_appautoscaling_target.notification_api.scalable_dimension
  service_namespace      = aws_appautoscaling_target.notification_api.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 80.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

resource "aws_appautoscaling_target" "email_sender" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.email_sender.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "email_sender_cpu" {
  name                   = "cpu-utilization"
  policy_type            = "TargetTrackingScaling"
  resource_id            = aws_appautoscaling_target.email_sender.resource_id
  scalable_dimension     = aws_appautoscaling_target.email_sender.scalable_dimension
  service_namespace      = aws_appautoscaling_target.email_sender.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 80.0
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}

