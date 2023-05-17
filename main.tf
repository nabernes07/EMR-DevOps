provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_role" "emr_studio_role" {
  name = "your-emr-studio-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticmapreduce.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "emr_studio_role_policy_attachment" {
  role       = aws_iam_role.emr_studio_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEMRStudioServicePolicy"
}


resource "aws_emr_studio" "emr_studio" {
  name                        = "your-studio-name"
  description                 = "Your EMR Studio"
  auth_mode                   = "IAM"
  vpc_id                      = "your_vpc_id"
  subnet_ids                  = ["subnet-1", "subnet-2"]
  default_s3_location         = "s3://your-bucket/emr-serverless/"
  engine_security_group_id    = "your_security_group_id"
  workspace_security_group_id = "your_security_group_id"
  service_role                = aws_iam_role.emr_studio_role.arn

  tags = {
    "Environment" = "Production"
  }
}

terraform {
  backend "s3" {
    bucket = "ecs-terraform-bernes"
    key    = "EMR-DevOps/terraform.tfstate"
    region = "ap-south-1"
  }
}
