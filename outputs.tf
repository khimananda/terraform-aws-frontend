output "distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
  description = "Cloudfront Distribution ID"
}

output "distribution_domain" {
    value = aws_cloudfront_distribution.s3_distribution.domain_name
    description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net"
}