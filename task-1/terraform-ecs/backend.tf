terraform {
  backend "s3" {
    bucket       = "terraform-state-abhiram"
    key          = "task-1/terraform-fargate/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
