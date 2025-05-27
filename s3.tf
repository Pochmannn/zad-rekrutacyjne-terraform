resource "aws_s3_bucket" "minio_remote_tier" {
  bucket = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.minio_remote_tier.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "upload_to_s3" {
  for_each = fileset("s3-test-files/", "*")
  depends_on = [aws_s3_bucket.minio_remote_tier]
  bucket = var.s3_bucket_name
  key    = each.value
  source = "s3-test-files/${each.value}"

  etag   = filemd5("s3-test-files/${each.value}")
}