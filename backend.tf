terraform {
  backend "s3" {
    bucket = "s3-golunch-infra-terraform-fiap-01"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}