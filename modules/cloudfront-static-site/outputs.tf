output "distribution_id" {
  value       = aws_cloudfront_distribution.this.id
  description = "CloudFront distribution ID."
}

output "distribution_domain_name" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "CloudFront domain name."
}

output "distribution_hosted_zone_id" {
  value       = aws_cloudfront_distribution.this.hosted_zone_id
  description = "Hosted zone ID to use for Route 53 alias records."
}
