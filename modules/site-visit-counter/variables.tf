variable "name" {
  description = "Name prefix for visit counter resources."
  type        = string
}

variable "counter_id" {
  description = "DynamoDB partition key value for the site counter."
  type        = string
  default     = "site"
}

variable "allowed_origins" {
  description = "Origins allowed to call the counter API. Use the site URL in production."
  type        = list(string)
  default     = ["*"]
}

variable "log_retention_days" {
  description = "CloudWatch log retention for the Lambda function."
  type        = number
  default     = 14
}

variable "tags" {
  description = "Tags to apply."
  type        = map(string)
  default     = {}
}
