variable "name" {
  description = "Name prefix for CloudFront resources."
  type        = string
}

variable "origin_domain_name" {
  description = "Origin domain name (S3 bucket regional domain name)."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN (must be in us-east-1 for CloudFront)."
  type        = string
}

variable "aliases" {
  description = "Domain aliases for the distribution."
  type        = list(string)
  default     = []
}

variable "default_root_object" {
  description = "Default root object."
  type        = string
  default     = "index.html"
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default     = {}
}
