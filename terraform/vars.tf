variable "AWS_REGION" {
  default = "us-east-1"
}

variable "ACCOUNT_ID" {
  default = "471112681286"
}

variable "API_GW_ARN" {
  #default = "arn:aws:apigateway:${AWS_REGION}:lambda:path/2015-03-31/functions/${modoaws_lambda_function.iot_function.arn}/invocations"
  default = ""
}

variable "lambda_function_name" {
  default = "iot_function"
}

variable "IOT_CERT_ARN" {
  default = "arn:aws:iot:us-east-1:471112681286:cert/76401898d4d0b02b8c2a9a445351b30e0dda7938f6da92c27c908fb57ef624fe"
}
