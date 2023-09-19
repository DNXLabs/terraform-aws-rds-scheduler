resource "aws_scheduler_schedule" "rds_stop" {
  count       = var.enable && !var.aurora_cluster ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-stop"
  description = "Stops RDS instance on a schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_stop})"
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StopRdsInstance:$DEFAULT"
    role_arn = aws_iam_role.event[0].arn
    input = jsonencode(
      {
        AutomationAssumeRole = [
          aws_iam_role.ssm_automation[0].arn,
        ]
        InstanceId = [
          var.identifier,
        ]
      }
    )
  }
}

resource "aws_scheduler_schedule" "rds_start" {
  count       = var.enable && !var.aurora_cluster ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-start"
  description = "Starts RDS instance on a schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_start})"
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StartRdsInstance:$DEFAULT"
    role_arn = aws_iam_role.event[0].arn
    input = jsonencode(
      {
        AutomationAssumeRole = [
          aws_iam_role.ssm_automation[0].arn,
        ]
        InstanceId = [
          var.identifier,
        ]
      }
    )
  }
}

resource "aws_scheduler_schedule" "aurora_stop" {
  count       = var.enable && !var.aurora_cluster ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-stop"
  description = "Stops Aurora instance on a schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_stop})"
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StartStopAuroraCluster:$DEFAULT"
    role_arn = aws_iam_role.event[0].arn
    input = jsonencode(
      {
        AutomationAssumeRole = [
          aws_iam_role.ssm_automation[0].arn,
        ]
        ClusterName = [
          var.identifier,
        ]
        Action = [
          "Stop",
        ]
      }
    )
  }
}

resource "aws_scheduler_schedule" "aurora_start" {
  count       = var.enable && !var.aurora_cluster ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-start"
  description = "Starts Aurora instance on a schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_stop})"
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StartStopAuroraCluster:$DEFAULT"
    role_arn = aws_iam_role.event[0].arn
    input = jsonencode(
      {
        AutomationAssumeRole = [
          aws_iam_role.ssm_automation[0].arn,
        ]
        ClusterName = [
          var.identifier,
        ]
        Action = [
          "Start",
        ]
      }
    )
  }
}