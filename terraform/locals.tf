locals {

  s3_origin_id = "StaticWebsite"

  common_tags = {
    Name        = "Test static website"
    Environment = "TST"
  }
}