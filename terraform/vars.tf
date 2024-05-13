variable "AWS_REGION" {
  default = "us-east-1"
}

variable "LAMBDA_FUNCTION_ARN" {
  default = "arn:aws:lambda:us-east-1:471112681286:function:iot-telegram-prod-notification"
}

variable "IOT_CERT_ARN" {
  default = "arn:aws:iot:us-east-1:471112681286:cert/76401898d4d0b02b8c2a9a445351b30e0dda7938f6da92c27c908fb57ef624fe"
}

variable "ACCOUNT_ID" {
  default =  "471112681286"
}