resource "aws_organizations_policy" "dev_scp" {
  name        = "DevRestrictedAccess"
  description = "Allow limited EC2, RDS, and S3 operations; restrict IAM and sensitive operations"
  content     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:RunInstances",
        "ec2:DescribeInstances",
        "rds:CreateDBInstance",
        "rds:DescribeDBInstances",
        "s3:PutObject"
      ],
      "Resource": "*",
      "Condition": {
        "StringEqualsIfExists": {
          "ec2:InstanceType": "t2.micro"
        },
        "StringEquals": {
          "s3:bucket": "arn:aws:s3:::your-dev-bucket-name"
        }
      }
    },
    {
      "Effect": "Deny",
      "Action": [
        "iam:*",
        "organizations:*",
        "account:*"
      ],
      "Resource": "*"
    }
  ]
}
POLICY

  type = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy" "test_scp" {
  name        = "TestReadOnlyAccess"
  description = "Allow read-only access to EC2, S3, and RDS services"
  content     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "s3:ListBucket",
        "s3:GetObject",
        "rds:Describe*",
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricData"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Deny",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
POLICY

  type = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy" "prod_scp" {
  name        = "ProdLimitedAccess"
  description = "Allow essential operations and restrict risky actions"
  content     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "s3:GetObject",
        "cloudwatch:GetMetricData",
        "cloudwatch:ListMetrics",
        "rds:Describe*",
        "s3:PutObject"  // Optional: include if uploads to a specific bucket are required
      ],
      "Resource": "*"
    },
    {
      "Effect": "Deny",
      "Action": [
        "ec2:TerminateInstances",
        "iam:*",
        "organizations:*",
        "account:*"
      ],
      "Resource": "*"
    }
  ]
}
POLICY

  type = "SERVICE_CONTROL_POLICY"
}


resource "aws_organizations_policy_attachment" "attach_dev_scp" {
  policy_id = aws_organizations_policy.dev_scp.id
  target_id = aws_organizations_organizational_unit.dev.id
}

resource "aws_organizations_policy_attachment" "attach_test_scp" {
  policy_id = aws_organizations_policy.test_scp.id
  target_id = aws_organizations_organizational_unit.test.id
}

resource "aws_organizations_policy_attachment" "attach_prod_scp" {
  policy_id = aws_organizations_policy.prod_scp.id
  target_id = aws_organizations_organizational_unit.prod.id
}
