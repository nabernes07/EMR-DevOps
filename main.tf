provider "aws" {
  region = "ap-south-1"
}

resource "aws_emr_studio" "uws-emrserverless-studio-nonprod" {
  auth_mode                   = "IAM"
  default_s3_location         = "s3://ecs-terraform-bernes/test"
  engine_security_group_id    = "sg-049092e56541cf6d8"
  name                        = "uws-emrserverless-studio-nonprod"
  service_role                = "arn:aws:iam::068003677592:role/aws-service-role/ops.emr-serverless.amazonaws.com/AWSServiceRoleForAmazonEMRServerless"
  subnet_ids                  = ["subnet-0acd8897043418623","subnet-0e4ad91050601aa5a"]
  vpc_id                      = "vpc-033ab8d7e34db0f84"
  workspace_security_group_id = "sg-0cab79414ed325660"
}


terraform {
    backend "s3" {
    bucket = "ecs-terraform-bernes"
    key = "EMR-DevOps/terraform.tfstate"
    region = "ap-south-1"
  }
}