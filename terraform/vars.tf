variable "lambda_function_name" {
  description = "lambda function name handling iot requests from aws iot"
  type        = string
  default     = "iot_function"
}

variable "iot_cert_arn" {
  description = "ARN of the IoT certificate"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}
