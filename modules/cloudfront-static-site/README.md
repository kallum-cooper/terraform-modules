# cloudfront-static-site

Creates a CloudFront distribution for a static site with an S3 origin using Origin Access Control (OAC).

## Inputs
- `origin_domain_name`
- `acm_certificate_arn` (must be us-east-1 for CloudFront)
- `aliases`
- `default_root_object`
- `tags`

## Outputs
- `distribution_id`
- `distribution_domain_name`
- `distribution_hosted_zone_id`
