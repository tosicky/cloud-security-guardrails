provider "aws" {
  region = var.region
  profile = "iamadmin-general"
  assume_role {
    role_arn = "arn:aws:iam::${var.workload_account_id}:role/OrganizationAccountAccessRole"
  }
}
