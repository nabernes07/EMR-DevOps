provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_role" "nonprod_role" {
  name               = "nonprod-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "",
    "Effect": "Allow",
    "Principal": {
      "Service": "elasticmapreduce.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
  }]
}
EOF
}

resource "aws_iam_policy" "nonprod_policy" {
  name        = "nonprod-policy"
  description = "Policy for EMR Studio"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "StudioAccess",
    "Effect": "Allow",
    "Action": [
      "emr-containers:StartJobRun",
      "emr-containers:DescribeJobRun",
      "emr-containers:CancelJobRun"
    ],
    "Resource": "*"
  }]
}
EOF
}

resource "aws_iam_role_policy_attachment" "emr_studio_role_policy_attachment" {
  role       = aws_iam_role.nonprod_role.name
  policy_arn = aws_iam_policy.nonprod_policy.arn
}

resource "aws_emr_studio" "uws-emrserverless-studio-nonprod" {
  auth_mode                   = "IAM"
  default_s3_location         = "s3://ecs-terraform-bernes/test"
  engine_security_group_id    = "sg-049092e56541cf6d8"
  name                        = "uws-emrserverless-studio-nonprod"
  service_role                = aws_iam_role.nonprod_role.arn
  subnet_ids                  = ["subnet-0acd8897043418623", "subnet-0e4ad91050601aa5a"]
  vpc_id                      = "vpc-033ab8d7e34db0f84"
  workspace_security_group_id = "sg-0cab79414ed325660"
}

terraform {
  backend "s3" {
    bucket = "ecs-terraform-bernes"
    key    = "EMR-DevOps/new/terraform.tfstate"
    region = "ap-south-1"
  }
}
