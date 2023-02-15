// Define a policy for the cache. 
// See more: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_cache_policy

resource "aws_cloudfront_cache_policy" "website" {
  name        = "static-website"
  comment     = "cache from cloudfront"
  default_ttl = 50
  max_ttl     = 100
  min_ttl     = 1
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"

    }
  }
}
