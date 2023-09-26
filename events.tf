resource "aws_scheduler_schedule" "rds_stop" {
  count       = var.enable ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-stop"
  description = "Stops RDS instance or cluster on a schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_stop})"
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = !var.aurora_cluster ? "arn:aws:scheduler:::aws-sdk:rds:stopDBInstance" : "arn:aws:scheduler:::aws-sdk:rds:stopDBCluster"
    role_arn = aws_iam_role.event[0].arn
    input = !var.aurora_cluster ? jsonencode(
      {
        DbInstanceIdentifier : var.identifier,
      }
      ) : jsonencode(
      {
        DbClusterIdentifier : var.identifier,

      }
    )
  }
}

resource "aws_scheduler_schedule" "rds_start" {
  count       = var.enable ? 1 : 0
  name        = "rds-scheduler-${var.identifier}-start"
  description = "Starts RDS instance or cluster on a schedule"
  group_name  = "default"

  schedule_expression          = "cron(${var.cron_start})"
  schedule_expression_timezone = var.schedule_timezone

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = !var.aurora_cluster ? "arn:aws:scheduler:::aws-sdk:rds:startDBInstance" : "arn:aws:scheduler:::aws-sdk:rds:startDBCluster"
    role_arn = aws_iam_role.event[0].arn
    input = !var.aurora_cluster ? jsonencode(
      {
        DBInstanceId = [
          var.identifier,
        ]
      }
      ) : jsonencode(
      {
        DbClusterIdentifier = [
          var.identifier,
        ]
      }
    )
  }
}