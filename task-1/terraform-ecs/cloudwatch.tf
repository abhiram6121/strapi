resource "aws_cloudwatch_log_group" "strapi" {
  name              = "/ecs/strapi-abhiram"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "ab-strapi-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 85
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.strapi.name
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "ab-strapi-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.strapi.name
  }
}

resource "aws_cloudwatch_metric_alarm" "taskcount_low" {
  alarm_name          = "ab-strapi-taskcount-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "RunningTaskCount"
  namespace           = "ECS/ContainerInsights"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.strapi.name
  }
}

resource "aws_cloudwatch_metric_alarm" "network_in_high" {
  alarm_name          = "ab-strapi-network-in-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkRxBytes"
  namespace           = "ECS/ContainerInsights"
  period              = 120
  statistic           = "Sum"
  threshold           = 5 * 1024 * 1024

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.strapi.name
  }
}

resource "aws_cloudwatch_metric_alarm" "network_out_high" {
  alarm_name          = "ab-strapi-network-out-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkTxBytes"
  namespace           = "ECS/ContainerInsights"
  period              = 120
  statistic           = "Sum"
  threshold           = 5 * 1024 * 1024

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.strapi.name
  }
}

resource "aws_cloudwatch_dashboard" "strapi" {
  dashboard_name = "ab-strapi-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          region  = var.aws_region
          title   = "CPU Utilization"
          view    = "timeSeries"
          stat    = "Average"
          period  = 60
          metrics = [["AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.strapi.name]]
          yAxis   = { left = { min = 0, max = 100 } }
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          region  = var.aws_region
          title   = "Memory Utilization"
          view    = "timeSeries"
          stat    = "Average"
          period  = 60
          metrics = [["AWS/ECS", "MemoryUtilization", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.strapi.name]]
          yAxis   = { left = { min = 0, max = 100 } }
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          region  = var.aws_region
          title   = "Running Task Count"
          view    = "timeSeries"
          stat    = "Average"
          period  = 60
          metrics = [["ECS/ContainerInsights", "RunningTaskCount", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.strapi.name]]
          yAxis   = { left = { min = 0 } }
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          region = var.aws_region
          title  = "Network Traffic (Bytes)"
          view   = "timeSeries"
          stat   = "Sum"
          period = 120
          metrics = [
            ["ECS/ContainerInsights", "NetworkRxBytes", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.strapi.name, { "label" : "Inbound", "stat" : "Sum" }],
            ["ECS/ContainerInsights", "NetworkTxBytes", "ClusterName", aws_ecs_cluster.main.name, "ServiceName", aws_ecs_service.strapi.name, { "label" : "Outbound", "stat" : "Sum" }]
          ]
        }
      }
    ]
  })
}
