variable "policy" {
  type        = string
  default     = "nonprod-policy"
  description = "description"
}

variable "role" {
  type        = string
  default     = "nonprod-role"
  description = "description"
}

variable "subnet_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "engine_security_group_id" {
  description = "List of security group IDs"
  type        = string
}

variable "name" {
  type        = string
  default     = "uws-emrserverless-studio-nonprod"
  description = "description"
}

variable "vpc_id" {
  description = "List of security group IDs"
  type        = string
}

variable "workspace_security_group_id" {
  description = "List of security group IDs"
  type        = string
}

variable "application_name" {
  type        = string
  default     = "uws-testing-application"
  description = "description"
}

variable "environment_type" {
  type        = string
  default     = "non-prod"
  description = "description"
}

variable "application" {
  type        = string
  default     = "uws"
  description = "description"
}


variable "maximum_cpu" {
  type        = string
  default     = "2000 vCPU"
  description = "description"
}


variable "maximum_memory" {
  type        = string
  default     = "10000 GB"
  description = "description"
}


variable "worker_cpu" {
  type        = string
  default     = "4 vCPU"
  description = "description"
}


variable "worker_memory" {
  type        = string
  default     = "20 GB"
  description = "description"
}


variable "worker1_cpu" {
  type        = string
  default     = "4 vCPU"
  description = "description"
}


variable "worker1_memory" {
  type        = string
  default     = "20 GB"
  description = "description"
}

