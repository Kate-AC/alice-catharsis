variable "name" {}
variable "policy" {}
variable "identifier" {}

resource "aws_lambda_function" "images_index" {
  function_name = "images_index"
  handler       = "images.index"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "ruby2.7"

  filename         = data.archive_file.function_source.output_path
  source_code_hash = data.archive_file.function_source.output_base64sha256

  environment {
    variables = {
      ENV = var.env
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy,
    aws_cloudwatch_log_group.lambda_images_index
  ]
}

resource "aws_lambda_permission" "images_index" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.images_index.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.current.execution_arn}/*/*/*"
}

output "api_path" {
  value = aws_iam_role.current.arn
}

