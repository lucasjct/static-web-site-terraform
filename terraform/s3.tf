// Create a static website with S3 Bucket. 
// Se more: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
// AWS Docs from S3 static website: https://docs.aws.amazon.com/pt_br/AmazonS3/latest/userguide/WebsiteHosting.html

// Create bucket
resource "aws_s3_bucket" "website" {
  bucket = random_pet.bucket_name.id

  tags = local.common_tags

}

// Defined access control list (ACL) for bucket. Just access for read
resource "aws_s3_bucket_acl" "website" {
  bucket = aws_s3_bucket.website.id
  acl    = "public-read"
}

// Enable or Disable versioning control
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Disabled"
  }
}

// Attached policy bucket for S3
resource "aws_s3_bucket_policy" "website" {

  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.allow_public_access.json

}

// Define the policy bucket for S3.

data "aws_iam_policy_document" "allow_public_access" {

  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]

    // statement for apply in the bucket created
    resources = ["${aws_s3_bucket.website.arn}/*"]
  }

}

// Pages that will do part of the site.
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id


  index_document {

    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

// sending objects for bucket. index.html will be sended
// See details: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_objects

resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  content_type = "text/html; charset=UTF-8"
  source       = "../website/index.html"
  etag         = filemd5("../website/index.html")

}

// sending objects for bucket. error.html will be sended
resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  content_type = "text/html; charset=UTF-8"
  source       = "../website/error.html"
  etag         = filemd5("../website/error.html")

}