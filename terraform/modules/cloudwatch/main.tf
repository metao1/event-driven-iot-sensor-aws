resource "aws_cloudwatch_log_group" "logs" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_cloudwatch_log_stream" "logs_stream" {
  name           = var.aws_cloudwatch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.logs.name
}
