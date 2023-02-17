# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket    = "jengomart-s3-terraform-remote-state"
    key       = "jengomart-webapplication.tfstate"
    region    = "us-west-1"
    profile   = "terraform-user"
  }
}