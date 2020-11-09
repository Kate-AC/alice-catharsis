resource "aws_api_gateway_resource" "tags" {
  rest_api_id = aws_api_gateway_rest_api.current.id
  parent_id   = aws_api_gateway_rest_api.current.root_resource_id
  path_part   = "tags"
}

module "tags_index" {
  source           = "./api"
  controller       = "tags"
  method           = "index"
  http_method      = "GET"
  role             = aws_iam_role.lambda_role.arn
  env              = var.env
  policy           = aws_iam_role_policy_attachment.lambda_policy
  log              = aws_cloudwatch_log_group.lambda_api
  rest_api_arn     = aws_api_gateway_rest_api.current.execution_arn
  rest_api_id      = aws_api_gateway_rest_api.current.id
  root_resource_id = aws_api_gateway_resource.tags.id
}

