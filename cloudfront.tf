locals {
  s3_origin_id = var.domain
}

resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name = "security-headers-policy"

  security_headers_config {
    frame_options {
      frame_option = "SAMEORIGIN"
      override     = true
    }
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.domain
  default_root_object = "index.html"

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 10
    error_code            = 403
    response_code         = 403
    response_page_path    = "/403.html"
  }

  aliases    = concat([var.domain], var.alias)
  web_acl_id = var.waf_frontend_arn


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    response_headers_policy_id = var.response_headers_policy_id
  }
   
  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations        = ["US", "CA", "NP", "IN"]
    }
  }

  tags = {
    Environment = terraform.workspace
  }

  viewer_certificate {
    ssl_support_method       = "sni-only"
    acm_certificate_arn      = var.certificate
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "${var.domain}-oac"
  description                       = "Origin Access Control for ${var.domain}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
