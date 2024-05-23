# module "apigateway" {
#   source               = "./modules/api_gw"
#   ACCOUNT_ID           = var.ACCOUNT_ID
#   AWS_REGION           = var.AWS_REGION
#   API_GW_ARN           = var.API_GW_ARN
#   lambda_function_name = var.lambda_function_name
# }

module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  ACCOUNT_ID           = var.ACCOUNT_ID
  AWS_REGION           = var.AWS_REGION
  source_arn           = ""
}


# IoT resources
# depends on cloudwatch and lambda
module "iot_thing" {
  source                    = "./modules/iot"
  LAMBDA_FUNCTION_ARN       = module.lambda.LAMBDA_FUNCTION_ARN
  cloudwatch_log_group_name = module.cloudwatch.log_group_name
  IOT_CERT_ARN              = var.IOT_CERT_ARN
  depends_on                = [module.cloudwatch, module.lambda]
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}
