resource "aws_cloudwatch_log_group" "lambda_images_index" {
  name = "/${var.env}/lambda/images_index"
}


