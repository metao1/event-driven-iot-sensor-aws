### Rule - Topic
resource "aws_iot_topic_rule" "rule_national_park_habitantes" {
  name        = "rule_national_park_habitantes"
  description = "Monitoring physiological conditions"
  enabled     = true
  sql         = var.rule_waters_national_park_habitantes_sql
  sql_version = var.sql_version

  lambda {
    function_arn = var.LAMBDA_FUNCTION_ARN
  }

  cloudwatch_logs {
    role_arn       = aws_iam_role.iot_logs_role.arn
    log_group_name = var.cloudwatch_log_group_name
  }
}

resource "aws_iot_topic_rule" "rule_national_park_habitantes_fire" {
  name        = "rule_national_park_habitantes_fire"
  description = "Monitoring possibility of fires"
  enabled     = true
  sql         = var.rule_national_park_habitantes_fire_sql
  sql_version = var.sql_version

  lambda {
    function_arn = var.LAMBDA_FUNCTION_ARN
  }

  cloudwatch_logs {
    role_arn       = aws_iam_role.iot_logs_role.arn
    log_group_name = var.cloudwatch_log_group_name
  }
}

resource "aws_iot_topic_rule" "rule_waters_national_park" {
  name        = "rule_waters_national_park"
  description = "Monitoring water quality"
  enabled     = true
  sql         = var.rule_waters_national_park_sql
  sql_version = var.sql_version

  lambda {
    function_arn = var.LAMBDA_FUNCTION_ARN
  }

  cloudwatch_logs {
    role_arn       = aws_iam_role.iot_logs_role.arn
    log_group_name = var.cloudwatch_log_group_name
  }
}

resource "aws_iot_topic_rule" "rule_connection_logs" {
  name        = "rule_connection_logs"
  description = "Monitoring connection logs"
  enabled     = true
  sql         = var.rule_connection_logs
  sql_version = "2016-03-23"

  cloudwatch_logs {
    role_arn       = aws_iam_role.iot_logs_role.arn
    log_group_name = var.cloudwatch_log_group_name
  }
}
