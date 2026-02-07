module "vpc" {
  source = "../../modules/test-vpc"
  name   = var.name
  cidr   = "10.10.0.0/16"
  azs    = ["us-east-1a", "us-east-1b"]
}
