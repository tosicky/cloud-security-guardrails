module "bucket" {
  source      = "../s3-secure-bucket"
  bucket_name = var.bucket_name
  kms_key_arn = var.kms_key_arn
}

resource "aws_s3_bucket_lifecycle_configuration" "lc" {
  bucket = module.bucket.bucket_id
  rule {
    id     = "retention"
    status = "Enabled"
    expiration { days = 365 }
  }
}
