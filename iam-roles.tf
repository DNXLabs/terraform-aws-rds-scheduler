
data "aws_iam_policy_document" "event" {
  count = var.enable ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["ssm:StartAutomationExecution"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = [aws_iam_role.ssm_automation[0].arn]
  }
}

data "aws_iam_policy_document" "event_trust" {
  count = var.enable ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "event" {
  count              = var.enable ? 1 : 0
  name_prefix        = "rds-scheduler-${var.identifier}-"
  assume_role_policy = data.aws_iam_policy_document.event_trust[0].json
}

resource "aws_iam_role_policy" "event" {
  count       = var.enable ? 1 : 0
  name_prefix = "rds-scheduler-${var.identifier}-"
  policy      = data.aws_iam_policy_document.event[0].json
  role        = aws_iam_role.event[0].name
}


data "aws_iam_policy_document" "ssm_automation_trust" {
  count = var.enable ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm_automation" {
  count              = var.enable ? 1 : 0
  name_prefix        = "rds-scheduler-ssm-${var.identifier}-"
  assume_role_policy = data.aws_iam_policy_document.ssm_automation_trust[0].json
}

resource "aws_iam_role_policy" "ssm_automation" {
  count       = var.enable ? 1 : 0
  name_prefix = "rds-scheduler-ssm-${var.identifier}-"
  role        = aws_iam_role.ssm_automation[0].name
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds:StopDB*",
        "rds:StartDB*",
        "rds:DescribeDBInstances"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ssm_automation" {
  count      = var.enable ? 1 : 0
  role       = aws_iam_role.ssm_automation[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole"
}
