package terraform.security

deny[msg] {
  some rc
  rc := input.resource_changes[_]
  rc.type == "aws_s3_bucket_public_access_block"
  rc.change.after.block_public_acls != true
  msg := "S3 buckets must block public ACLs"
}
