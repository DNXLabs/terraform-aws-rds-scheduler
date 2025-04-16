# Generate a random string to add it to the name of the Target Group
resource "random_string" "iam_suffix" {
  length      = 12
  numeric     = true
  min_numeric = 12
}

resource "aws_iam_role" "event" {
  count = var.enable ? 1 : 0
  name  = substr("rds-scheduler-${var.identifier}-${random_string.iam_suffix.result}", 0, 64)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = ["scheduler.amazonaws.com"]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "event_policy" {
  count = var.enable ? 1 : 0
  name  = "rds-scheduler-policy-${var.identifier}-${random_string.iam_suffix.result}"
  role  = aws_iam_role.event[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow"
        Resource : ["*"]
        Action : [
          "rds:StopDB*",
          "rds:StartDB*",
          "rds:DescribeDBInstances",
          "rds:StartDBCluster",
          "rds:StopDBCluster",
          "rds:DescribeDBClusters"
        ]
      }
    ]
  })
}


