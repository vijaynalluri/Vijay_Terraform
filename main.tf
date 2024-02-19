resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}
//ownership controls
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
//opening access to public 
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
//acl for public to read
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.my_bucket.id
  acl    = "public-read"
}
//adding index.html object to bucket
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
  content_type = "text/html"
}
//adding error.html to bucket
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.my_bucket.id
  key    = "error.html"
  source = "error.html"
  acl    = "public-read"
  content_type = "text/html"
}
//website configuration
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

    depends_on = [ aws_s3_bucket_acl.example ]

}