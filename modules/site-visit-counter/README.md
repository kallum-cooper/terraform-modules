# site-visit-counter

Creates a simple public visit counter API for a static site.

The API uses:

- DynamoDB for an atomic counter
- Lambda for incrementing and returning the count
- API Gateway HTTP API for a small browser-callable endpoint

This counts requests to the counter endpoint. It does not count unique visitors.

## Inputs

- `name`
- `counter_id`
- `allowed_origins`
- `log_retention_days`
- `tags`

## Outputs

- `api_endpoint`
- `counter_url`
- `table_name`
- `lambda_function_name`

## Example

```hcl
module "site_visit_counter" {
  source = "../../modules/site-visit-counter"

  name            = "kallumcooper-site"
  allowed_origins = ["https://kallumcooper.co.uk"]

  tags = {
    Project = "kallumcooper-site"
  }
}
```

Use `module.site_visit_counter.counter_url` in the site JavaScript.
