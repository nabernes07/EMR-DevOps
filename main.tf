provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_role" "nonprod_role" {
  name               = var.role
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
  name        = var.policy
  description = "Policy for EMR Studio"

  policy = <<EOF
{
    "Statement": [
        {
            "Action": [
                "emr-containers:StartJobRun",
                "emr-containers:DescribeJobRun",
                "emr-containers:CancelJobRun",
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "*",
            "Sid": "StudioAccess"
        }
    ],
    "Version": "2012-10-17"
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
  engine_security_group_id    = var.engine_security_group_id
  name                        = var.name
  service_role                = aws_iam_role.nonprod_role.arn
  subnet_ids                  = var.subnet_ids
  vpc_id                      = var.vpc_id
  workspace_security_group_id = var.workspace_security_group_id
}

resource "aws_emrserverless_application" "click_log_loggregator_emr_serverless" {
  name          = var.application
  release_label = "emr-6.9.0"
  type          = "spark"

  initial_capacity {
    initial_capacity_type = "Driver"

    initial_capacity_config {
      worker_count = 1
      worker_configuration {
        cpu    = var.worker_cpu
        memory = var.worker_memory
      }
    }
  }

  initial_capacity {
    initial_capacity_type = "Executor"

    initial_capacity_config {
      worker_count = 3
      worker_configuration {
        cpu    = var.worker1_cpu
        memory = var.worker1_memory
      }
    }
  }

  maximum_capacity {
    cpu    = var.cpu
    memory = var.memory
  }

  tags = {
    application-name = var.application_name
    environment-type = var.environment_type
  }
}

terraform {
  backend "s3" {
    bucket = "ecs-terraform-bernes"
    key    = "EMR-DevOps/new/terraform.tfstate"
    region = "ap-south-1"
  }
}
