terraform {
  backend "s3" {
    bucket = "s3-golunch-infra-terraform-fiap"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}