# Secure bucket
# Results in 1C 1H 1M 2L


resource "aws_kms_key" "bucket-dr4-kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation = true
  policy = "{}"
}

resource "aws_s3_bucket" "bucket-dr4" {
  bucket = "oak9cp-secure-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-dr4-sse-config" {
  bucket = aws_s3_bucket.bucket-dr4.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucket-dr4-kms-key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
