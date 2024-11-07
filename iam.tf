# Define Cross Account Role (same as your original code)
resource "aws_iam_role" "cross_account_role" {
  name               = "CrossAccountAccessRole"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::<root-account-id>:root"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "CrossAccountAccessRole"
  }
}

# Define Cross Account Policy (same as your original code)
resource "aws_iam_role_policy" "cross_account_policy" {
  name   = "CrossAccountAccessPolicy"
  role   = aws_iam_role.cross_account_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeInstances",
          "s3:ListBucket",
          "rds:DescribeDBInstances",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricData"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Define the Dev Account


# Attach the cross account role to the Dev Account
resource "aws_iam_role_policy_attachment" "dev_account_cross_account_attachment" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_role_policy.cross_account_policy.id
  depends_on = [aws_organizations_account.dev_account]
}

# Attach the cross account role to the Test Account
resource "aws_iam_role_policy_attachment" "test_account_cross_account_attachment" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_role_policy.cross_account_policy.id
  depends_on = [aws_organizations_account.test_account]
}

# Attach the cross account role to the Test Account
resource "aws_iam_role_policy_attachment" "prod_account_cross_account_attachment" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_role_policy.cross_account_policy.id
  depends_on = [aws_organizations_account.prod_account]
}


