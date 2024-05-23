# Define the API Gateway resources
resource "aws_api_gateway_rest_api" "iot_api_gw" {
  name        = "iot-app"
  description = "API Gateway for iot-app"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_gw_resource" {
  rest_api_id = aws_api_gateway_rest_api.iot_api_gw.id
  parent_id   = aws_api_gateway_rest_api.iot_api_gw.root_resource_id
  path_part   = "iot"
}

resource "aws_api_gateway_method" "iot_method" {
  rest_api_id   = aws_api_gateway_rest_api.iot_api_gw.id
  resource_id   = aws_api_gateway_resource.api_gw_resource.rest_api_id
  http_method   = "GET"
  authorization = "NONE"
}

# Define the API Gateway integration
resource "aws_api_gateway_integration" "iot_integration" {
  rest_api_id             = aws_api_gateway_rest_api.iot_api_gw.id
  resource_id             = aws_api_gateway_resource.api_gw_resource.rest_api_id
  http_method             = aws_api_gateway_method.iot_method.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = var.API_GW_ARN
}

# Ensure that the Lambda function triggers on API Gateway deployment
resource "aws_api_gateway_deployment" "iot_deployment" {
  depends_on = [aws_api_gateway_integration.iot_integration]

  rest_api_id = aws_api_gateway_rest_api.iot_api_gw.id
  stage_name  = "prod"
}
