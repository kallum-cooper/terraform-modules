provider "aws" {
  region = "eu-west-1"
}

module "site_visit_counter" {
  source = "../.."

  name            = "example-site"
  allowed_origins = ["https://example.com"]

  tags = {
    Project = "example-site"
  }
}

output "counter_url" {
  value = module.site_visit_counter.counter_url
}
