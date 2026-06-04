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

## How it works

The module creates a small serverless counter API:

```text
Visitor opens site
  -> browser calls the counter URL
  -> API Gateway receives GET /count
  -> API Gateway invokes Lambda
  -> Lambda atomically increments DynamoDB
  -> Lambda returns { "count": 123 }
  -> browser displays the visit count
```

The DynamoDB table stores the counter value. It uses `PAY_PER_REQUEST` billing, so there is no fixed capacity to manage. The table key is `counter_id`, which lets the same table shape support one or more counters. By default, the module uses `site`.

The Lambda function is packaged from `files/lambda.py`. On each request, it runs a DynamoDB `UpdateItem` call with `ADD visits :increment`, which makes the increment atomic even when multiple visitors load the site at the same time.

API Gateway exposes the public HTTP endpoint and routes `GET /count` to the Lambda function. The `counter_url` output is the full browser-callable endpoint to place in the static site configuration.

IAM resources give the Lambda only the permissions it needs: updating the DynamoDB table and writing CloudWatch logs. The CloudWatch log group uses `log_retention_days` so logs do not build up indefinitely.

This endpoint is public by design. `allowed_origins` controls browser CORS access, but it is not authentication. Anyone with the URL can call it, so this module is suitable for low-risk counters rather than sensitive analytics.
