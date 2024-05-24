# Define the Lambda function that will be triggered by IoT
module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  accout_id            = var.iot_cert_arn
  aws_region           = var.aws_region
  log_group_name       = module.cloudwatch.log_group_name
}


# IoT resources that creates a MQTT broker on AWS IoT gateway
# depends on cloudwatch and lambda
module "iot_thing" {
  source                    = "./modules/iot"
  cloudwatch_log_group_name = module.cloudwatch.log_group_name
  lambda_function_name      = module.lambda.LAMBDA_FUNCTION_ARN
  iot_cert_arn              = var.iot_cert_arn
  depends_on                = [module.cloudwatch, module.lambda]
}

# Define the CloudWatch resources that will be used for logging from Lambda and IoT
module "cloudwatch" {
  source = "./modules/cloudwatch"
}
