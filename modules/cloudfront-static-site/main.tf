resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.name}-oac"
  description                       = "OAC for ${var.name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_function" "directory_index" {
  count   = var.directory_indexes_enabled ? 1 : 0
  name    = "${var.name}-directory-index"
  runtime = "cloudfront-js-2.0"
  comment = "Resolve static site directory URLs to index.html"
  publish = true
  code    = file("${path.module}/files/directory-index.js")
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.name
  default_root_object = var.default_root_object
  aliases             = var.aliases

  origin {
    domain_name              = var.origin_domain_name
    origin_id                = "s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]

    dynamic "function_association" {
      for_each = var.directory_indexes_enabled ? [1] : []
      content {
        event_type   = "viewer-request"
        function_arn = aws_cloudfront_function.directory_index[0].arn
      }
    }

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = var.tags
}
