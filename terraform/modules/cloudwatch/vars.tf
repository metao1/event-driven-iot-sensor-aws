variable "cloudwatch_log_group_name" {
  default = "iot_logs_group"
}

variable "aws_cloudwatch_log_stream_name" {
  default = "iot_logs_stream"
}

variable "log_retention_days" {
  default = 7
}
