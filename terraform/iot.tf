// terraform/iot.tf 
# IoT resources

### Rule - National
resource "aws_iot_thing" "rule_national" {
  name = "rule_national"
}

# Policy for certification
resource "aws_iot_policy" "iot_rule_national_policy" {
  name = "iot_rule_national_policy"

  policy = jsonencode({         
        "Version": "2012-10-17",
        "Statement": [
                {
                 "Action": ["iot:*"],
                 "Effect": "Allow",
                 "Resource": "${var.IOT_CERT_ARN}"
                }
        ]
    }
  )

  lifecycle {
    create_before_destroy = true
  }  
}

resource "aws_iot_policy_attachment" "rule_national_policy_att" {
  policy = aws_iot_policy.iot_rule_national_policy.name
  target = var.IOT_CERT_ARN
}

resource "aws_iot_thing_principal_attachment" "rule_national_thing_att" {
  principal = var.IOT_CERT_ARN
  thing     = aws_iot_thing.rule_national.name
}


# Define the Lambda execution role
resource "aws_iam_role" "iot_logs_role" {
  name = "iot_logs_role"
        
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "iot.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
   })

   inline_policy {
    name = "iot_logs_policy"

    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "iot:Connect",
            "iot:Subscribe",
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource": "*"
        }
      ]
    })
  }
}


### Rule - Topic
resource "aws_iot_topic_rule" "rule_national_park_habitantes" {
  name        = "rule_national_park_habitantes"
  description = "Monitoring physiological conditions"
  enabled     = true
  sql         = "SELECT * FROM 'habitante' where temperatura >= 39"
  sql_version = "2016-03-23"

  lambda {
    function_arn     = var.LAMBDA_FUNCTION_ARN
  }

  cloudwatch_logs {
    role_arn = aws_iam_role.iot_logs_role.arn
    log_group_name = aws_cloudwatch_log_group.iot_logs.name    
  }
}

resource "aws_iot_topic_rule" "rule_national_park_habitantes_fire" {
  name        = "rule_national_park_habitantes_fire"
  description = "Monitoring possibility of fires"
  enabled     = true
  sql         = "SELECT * FROM 'queimadas' where co2 >= 7"
  sql_version = "2016-03-23"

  lambda {
    function_arn        = var.LAMBDA_FUNCTION_ARN
  }

  cloudwatch_logs {
    role_arn = aws_iam_role.iot_logs_role.arn
    log_group_name = aws_cloudwatch_log_group.iot_logs.name    
  }
}

resource "aws_iot_topic_rule" "rule_waters_national_park" {
  name        = "rule_waters_national_park"
  description = "Monitoring water quality"
  enabled     = true
  sql         = "SELECT * FROM 'aguas' where ph >= 5"
  sql_version = "2016-03-23"

  lambda {
    function_arn     = var.LAMBDA_FUNCTION_ARN
  }

  cloudwatch_logs {
    role_arn = aws_iam_role.iot_logs_role.arn
    log_group_name = aws_cloudwatch_log_group.iot_logs.name    
  }
}

resource "aws_cloudwatch_log_group" "iot_logs" {
  name = "iot_logs"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "iot_logs_stream" {
  name = "iot_logs_stream"
  log_group_name = aws_cloudwatch_log_group.iot_logs.name
}

resource "aws_iot_topic_rule" "rule_connection_logs" {
  name        = "rule_connection_logs"
  description = "Monitoring connection logs"
  enabled     = true
  sql         = "SELECT * FROM '$aws/things/+/shadow/+/accepted' WHERE status = 'offline'"
  sql_version = "2016-03-23"
  
  cloudwatch_logs {
    role_arn = aws_iam_role.iot_logs_role.arn
    log_group_name = aws_cloudwatch_log_group.iot_logs.name
  }
}
