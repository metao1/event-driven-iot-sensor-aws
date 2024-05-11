variable "AWS_REGION" {
  default = "us-east-1"
}

variable "LAMBDA_FUNCTION_ARN" {
  default = "arn:aws:lambda:us-east-1:471112681286:function:iot-telegram-prod-notification"
}

variable "IOT_CERT_ARN" {
  default = "arn:aws:iot:us-east-1:471112681286:cert/1483ba6ca3a3315d7a50d4e1926ef1490318646b55292af7acba16bdebf134dc"
}