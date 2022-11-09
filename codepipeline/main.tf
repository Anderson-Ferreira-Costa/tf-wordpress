terraform {
  backend "s3" {
    bucket  = "anderson-ferreira"
    key     = "terraform-state/wordpress-codepipeline/terraform.tfstate"
    region  = "us-east-1"
#    profile = "anderson"
  }
}
provider "aws" {
  region  = "us-east-1"
#  profile = "anderson"
}