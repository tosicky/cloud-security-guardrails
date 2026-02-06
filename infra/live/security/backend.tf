terraform {
  backend "s3" {
    bucket         = "cloud-sec-org-bucket"
    key            = "security-platform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}