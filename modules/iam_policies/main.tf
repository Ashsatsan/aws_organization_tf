resource "aws_iam_role" "cross_account_role" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": var.root_account_arn
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "cross_account_policy" {
  name   = var.policy_name
  role   = aws_iam_role.cross_account_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": var.policy_actions,
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_role_policy.cross_account_policy.id
  depends_on = var.depends_on_accounts
}
