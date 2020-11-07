resource "aws_api_gateway_rest_api" "current" {
  name        = "Alice-Catharsis-API"
  description = "This is used as backend on Alice-Catharsis."
}

resource "aws_api_gateway_deployment" "production" {
  stage_name  = "production"
  depends_on  = [aws_api_gateway_rest_api.current]
  rest_api_id = aws_api_gateway_rest_api.current.id

  triggers = {
    redeployment = "v0.1"
  }
}

resource "aws_api_gateway_domain_name" "production" {
  domain_name              = "api.${var.domain}"
  regional_certificate_arn = aws_acm_certificate_validation.current.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "current" {
  depends_on  = [aws_api_gateway_deployment.production]
  api_id      = aws_api_gateway_rest_api.current.id
  stage_name  = aws_api_gateway_deployment.production.stage_name
  domain_name = aws_api_gateway_domain_name.production.domain_name
}

resource "aws_api_gateway_resource" "images" {
  rest_api_id = aws_api_gateway_rest_api.current.id
  parent_id   = aws_api_gateway_rest_api.current.root_resource_id
  path_part   = "images"
}

resource "aws_api_gateway_method" "images_index" {
  rest_api_id   = aws_api_gateway_rest_api.current.id
  resource_id   = aws_api_gateway_resource.images.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "production" {
  rest_api_id             = aws_api_gateway_rest_api.current.id
  resource_id             = aws_api_gateway_resource.images.id
  http_method             = aws_api_gateway_method.images_index.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.images_index.invoke_arn
}

