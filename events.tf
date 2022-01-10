resource "aws_cloudwatch_event_rule" "rds_stop" {
  count               = var.enable ? 1 : 0
  name                = "rds-scheduler-${var.identifier}-stop"
  description         = "Stops RDS instance on a schedule"
  schedule_expression = "cron(${var.cron_stop})"
}

resource "aws_cloudwatch_event_target" "rds_stop" {
  count = var.enable && !var.aurora_cluster ? 1 : 0
  arn   = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StopRdsInstance:$DEFAULT"
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
  role_arn  = aws_iam_role.event[0].arn
  rule      = aws_cloudwatch_event_rule.rds_stop[0].name
  target_id = "rds-scheduler-${var.identifier}-stop"
}

resource "aws_cloudwatch_event_rule" "rds_start" {
  count               = var.enable ? 1 : 0
  name                = "rds-scheduler-${var.identifier}-start"
  description         = "Starts RDS instance on a schedule"
  schedule_expression = "cron(${var.cron_start})"
}

resource "aws_cloudwatch_event_target" "rds_start" {
  count = var.enable && !var.aurora_cluster ? 1 : 0
  arn   = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StartRdsInstance:$DEFAULT"
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
  role_arn  = aws_iam_role.event[0].arn
  rule      = aws_cloudwatch_event_rule.rds_start[0].name
  target_id = "rds-scheduler-${var.identifier}-start"
}

resource "aws_cloudwatch_event_target" "aurora_stop" {
  count = var.enable && var.aurora_cluster ? 1 : 0
  arn   = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StartStopAuroraCluster:$DEFAULT"
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
  role_arn  = aws_iam_role.event[0].arn
  rule      = aws_cloudwatch_event_rule.rds_stop[0].name
  target_id = "rds-scheduler-${var.identifier}-stop"
}

resource "aws_cloudwatch_event_target" "aurora_start" {
  count = var.enable && var.aurora_cluster ? 1 : 0
  arn   = "arn:aws:ssm:${data.aws_region.current.name}::automation-definition/AWS-StartStopAuroraCluster:$DEFAULT"
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
  role_arn  = aws_iam_role.event[0].arn
  rule      = aws_cloudwatch_event_rule.rds_start[0].name
  target_id = "rds-scheduler-${var.identifier}-start"
}
