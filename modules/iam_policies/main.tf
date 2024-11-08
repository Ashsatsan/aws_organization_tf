resource "aws_iam_role" "cross_account_role" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": var.root_account_arn  # Root account ARN
        },
        "Action": "sts:AssumeRole",
        "Resource": [
          # Allow cross-account access to all the accounts (dev, test, prod)
          "arn:aws:iam::*:role/role-name-in-dev",   # Role in the dev account
          "arn:aws:iam::*:role/role-name-in-test",  # Role in the test account
          "arn:aws:iam::*:role/role-name-in-prod"   # Role in the prod account
        ]
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
