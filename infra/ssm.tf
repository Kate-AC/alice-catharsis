resource "aws_ssm_parameter" "lambda_webhook_url" {
  name = "/lambda/webhook_url"
  value = "uninitialized"
  type = "SecureString"

  lifecycle {
    ignore_changes = [value]
  }
}
