# s3-private-origin-bucket

Creates an S3 bucket intended to be used as a **private origin** (e.g. behind CloudFront).

## What it creates
- S3 bucket
- Public access block (all public access blocked)
- Optional versioning

## Inputs
- `bucket_name` (string, required)
- `tags` (map(string), optional)
- `versioning_enabled` (bool, optional)

## Outputs
- `bucket_name`
- `bucket_arn`
- `bucket_regional_domain_name`
