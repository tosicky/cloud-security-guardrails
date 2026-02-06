terraform {
  backend "s3" {
    bucket         = "cloud-sec-org-bucket"
    key            = "mgmt-bootstrap/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}