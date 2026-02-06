provider "aws" {
  region = var.region
  profile = "iamadmin-general"
  # assume_role {
  #   role_arn = "arn:aws:iam::061451663077:role/github-org-bootstrap"
  # }
}
