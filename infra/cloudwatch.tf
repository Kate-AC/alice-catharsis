resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "ecs/production"
  retention_in_days = 180

  tags = {
    Name = "${var.env}"
  }
}

