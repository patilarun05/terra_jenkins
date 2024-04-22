terraform {
  backend "s3" {
    bucket = "s3backend-tf"
    key    = "global/s3/terraform.tfstate"
    region = "ap-south-1"
  }
}