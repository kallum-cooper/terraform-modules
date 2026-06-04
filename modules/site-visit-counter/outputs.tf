output "api_endpoint" {
  description = "Base URL for the visit counter API."
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "counter_url" {
  description = "URL that increments and returns the visit count."
  value       = "${aws_apigatewayv2_api.this.api_endpoint}/count"
}

output "table_name" {
  description = "DynamoDB table name storing the counter."
  value       = aws_dynamodb_table.this.name
}

output "lambda_function_name" {
  description = "Lambda function name."
  value       = aws_lambda_function.this.function_name
}
