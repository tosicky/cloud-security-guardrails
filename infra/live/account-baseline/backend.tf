terraform {
  backend "s3" {
    bucket         = "cloud-sec-org-bucket"
    key            = "account-baseline/accounts/${var.workload_account_id}.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
