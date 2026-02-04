resource "aws_config_config_rule" "s3_public_read" {
  name = "s3-public-read-prohibited"
  source { 
    owner = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED" 
    }
}

resource "aws_config_config_rule" "encrypted_volumes" {
  name = "encrypted-volumes"
  source { 
    owner = "AWS" 
    source_identifier = "ENCRYPTED_VOLUMES" 
    }
}

resource "aws_config_config_rule" "cloudtrail_enabled" {
  name = "cloudtrail-enabled"
  source { 
    owner = "AWS" 
    source_identifier = "CLOUD_TRAIL_ENABLED" 
    }
}
