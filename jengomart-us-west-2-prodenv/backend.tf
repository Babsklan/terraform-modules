# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket    = "jengomart-s3-terraform-remote-state-us-west-2"
    key       = "jengomart-webapplication.tfstate"
    region    = "us-west-2"
    profile   = "terraform-user"
  }
}