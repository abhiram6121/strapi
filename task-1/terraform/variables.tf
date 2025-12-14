variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "key_name" {
  description = "EC2 SSH Key Pair name"
  default     = "strapi-app"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  default     = "301782007642"
}

variable "ecr_repo_name" {
  description = "ECR repo name"
  type        = string
  default     = "strapi-cms"
}

variable "docker_image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

variable "db_name" {
  description = "Database name"
  default     = "strapidb"
}

variable "db_username" {
  description = "DB username"
  default     = "strapi"
}

# Sensitive vars, no defaults. Set in terraform.tfvars
variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "DB password"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT secret"
  type        = string
  sensitive   = true
}

variable "admin_jwt_secret" {
  description = "Admin JWT secret"
  type        = string
  sensitive   = true
}

variable "app_keys" {
  description = "Application keys"
  type        = string
  sensitive   = true
}

variable "api_token_salt" {
  description = "API token salt"
  type        = string
  sensitive   = true
}
