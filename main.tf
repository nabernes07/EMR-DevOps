resource "aws_emr_studio" "uws-emrserverless-studio-nonprod" {
  auth_mode                   = "IAM"
  default_s3_location         = "s3://cloudops-emrserverless/emr-serverless/"
  engine_security_group_id    = sg-077a2d1f378103407
  name                        = "uws-emrserverless-studio-nonprod"
  service_role                = arn:aws:iam::904541710863:role/emr-notebook-role
  subnet_ids                  = [subnet-0091d45f89f2e267b, subnet-01fe66d8d5b0efb18]
  vpc_id                      = vpc-006438faf6005e56c
  workspace_security_group_id = sg-0e63af6afb024313a
}
 

resource "aws_emrserverless_application" "click_log_loggregator_emr_serverless" {
  name          = "uws-testing-application"
  release_label = "emr-6.9.0"
  type          = "spark"
 
  initial_capacity {
    initial_capacity_type = "Driver"
 
    initial_capacity_config {
      worker_count = 1
      worker_configuration {
        cpu    = "4 vCPU"
        memory = "20 GB"
      }
    }
  }
 
  initial_capacity {
    initial_capacity_type = "Executor"
 
    initial_capacity_config {
      worker_count = 3
      worker_configuration {
        cpu    = "4 vCPU"
        memory = "20 GB"
      }
    }
  }
 
  maximum_capacity {
    cpu    = "2000 vCPU"
    memory = "10000 GB"
  }
network_configuration = {
    subnet_ids = ["subnet-04678cf437bfdfc99", "subnet-0702bed9041a4a61e", "subnet-0007ae6c2e9652b76"]
  }
  tags = {
    nbcu:application-name = "uws"
    nbcu:enviornment-type = "non-prod"
  }
}
