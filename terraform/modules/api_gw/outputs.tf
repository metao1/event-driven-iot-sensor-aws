output "api_gw_resource" {
  value = aws_api_gateway_resource.api_gw_resource
}

output "aws_api_gateway_rest_api" {
  value = aws_api_gateway_integration.iot_integration.rest_api_id
}
