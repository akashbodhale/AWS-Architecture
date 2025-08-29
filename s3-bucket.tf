resource "random_id" "random_hex" {
    byte_length = 8
  
}

resource "aws_s3_bucket" "test_bucket" {
    bucket=format("%s-%s",var.gogreen-s3,random_id.random_hex) 
    tags = {
      Name="my bucket"
      Environment="Dev"
    }
}

resource "aws_kms_key" "s3_bucket_kms_key" {
    description = "KMS key for s3 bucket"
    deletion_window_in_days = 7
    tags={
        name="KMS key for s3 bucket"
    }
}

resource "aws_kms_alias" "s3_bucket_kms_key_alias" {
  name="alias/s3_bucket_kms_key_alias"
  target_key_id = aws_kms_key.s3_bucket_kms_key.id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption_with_kms_key" {
    bucket=aws_s3_bucket.test_bucket.id
    rule{
        apply_server_side_encryption_by_default {
          kms_master_key_id = aws_kms_key.s3_bucket_kms_key.arn
          sse_algorithm = "aws:kms"
        }
    }
}

resource "aws_s3_bucket_policy" "test_bucket_policy" {

    bucket = aws_s3_bucket.id
    policy= jsonencode({
        version="2012-10-17"
        statement=[{
            Effect="allow"
            principle="*"
            action=["s3.putObject","s3.GetObject"]
            resource= "${aws_s3_bucket.test_bucket.arn}/*"
        }]
    })
    depends_on = [aws_s3_bucket_public_access_block.enable_public_access]
}

resource "aws_s3_bucket_public_access_block" "enable_public_access" {
  bucket = aws_s3_bucket.test_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.test_bucket.id

  rule {
    id = "config"

    filter {
      prefix = "config/"
    }

    noncurrent_version_expiration {
      noncurrent_days = 180
    }

    noncurrent_version_transition {
      noncurrent_days = 90
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }
}
