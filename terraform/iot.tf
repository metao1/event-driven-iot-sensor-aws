# resource "aws_iot_thing" "rule_national" {
#   name = "rule_national"
# }

# # Policy of certification
# resource "aws_iot_policy" "rule_national_policy" {
#   name = "rule_national_policy"

#   policy = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": [
#           "iot:*"
#         ],
#         "Effect": "Allow",
#         "Resource": "*"
#       }
#     ]
#   }
#   EOF
# }

# resource "aws_iot_policy_attachment" "rule_national_policy_att" {
#   policy = aws_iot_policy.rule_national_policy.name
#   target = var.IOT_CERT_ARN
# }

# resource "aws_iot_thing_principal_attachment" "rule_national_thing_att" {
#   principal = var.IOT_CERT_ARN
#   thing     = aws_iot_thing.rule_national.name
# }


# ### Rule - Topic
# resource "aws_iot_topic_rule" "rule_national_park_habitantes" {
#   name        = "rule_national_park_habitantes"
#   description = "Monitoring physiological conditions"
#   enabled     = true
#   sql         = "SELECT * FROM 'habitante' where temperatura >= 39"
#   sql_version = "2016-03-23"

#   lambda {
#     function_arn     = var.LAMBDA_FUNCTION_ARN
#   }
# }

# resource "aws_iot_topic_rule" "rule_national_park_habitantes_fire" {
#   name        = "rule_national_park_habitantes_fire"
#   description = "Monitoring possibility of fires"
#   enabled     = true
#   sql         = "SELECT * FROM 'queimadas' where co2 >= 7"
#   sql_version = "2016-03-23"

#   lambda {
#     function_arn        = var.LAMBDA_FUNCTION_ARN
#   }
# }

# resource "aws_iot_topic_rule" "rule_waters_national_park" {
#   name        = "rule_waters_national_park"
#   description = "Monitoring water quality"
#   enabled     = true
#   sql         = "SELECT * FROM 'aguas' where ph >= 5"
#   sql_version = "2016-03-23"

#   lambda {
#     function_arn     = var.LAMBDA_FUNCTION_ARN
#   }
# }