resource "aws_api_gateway_resource" "contacts" {
  rest_api_id = aws_api_gateway_rest_api.current.id
  parent_id   = aws_api_gateway_rest_api.current.root_resource_id
  path_part   = "contacts"
}

module "contacts_mail" {
  source           = "./api"
  controller       = "contacts"
  method           = "mail"
  http_method      = "POST"
  role             = aws_iam_role.lambda_role.arn
  env              = var.env
  policy           = aws_iam_role_policy_attachment.lambda_policy
  log              = aws_cloudwatch_log_group.lambda_api
  rest_api_arn     = aws_api_gateway_rest_api.current.execution_arn
  rest_api_id      = aws_api_gateway_rest_api.current.id
  root_resource_id = aws_api_gateway_resource.contacts.id
}

