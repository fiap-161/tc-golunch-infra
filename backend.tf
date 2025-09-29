terraform {
  backend "s3" {
    bucket = "terraform-state-934954943528-golunch-infra"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}