resource "aws_cloudwatch_log_group" "lambda_api" {
  name = "/${var.env}/lambda/api"
}


