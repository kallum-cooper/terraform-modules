# cloudfront-static-site

Creates a CloudFront distribution for a static site with an S3 origin using Origin Access Control (OAC).

## Inputs
- `origin_domain_name`
- `acm_certificate_arn` (must be us-east-1 for CloudFront)
- `aliases`
- `default_root_object`
- `tags`
- `directory_indexes_enabled` (default `false`) — optionally rewrite directory URLs to `index.html` using a viewer-request CloudFront Function. This supports Hugo's nested pages with a private S3 origin.

Run URL rewrite checks with `node --test modules/cloudfront-static-site/tests/directory-index.test.cjs` from the repository root.

## Outputs
- `distribution_id`
- `distribution_domain_name`
- `distribution_hosted_zone_id`
