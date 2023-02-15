output "url_site_s3" {

  // choice website_endpoint for show uri in console when the process to be finished
  value = aws_s3_bucket_website_configuration.website.website_endpoint

}



output "domain_name_cloud_front" {

  value = aws_cloudfront_distribution.s3_distribution.domain_name
  
}
