# IoT resources

### Rule - National
resource "aws_iot_thing" "rule_national" {
  name = var.iot_thing_name
}

resource "aws_iot_policy_attachment" "rule_national_policy_att" {
  policy = aws_iot_policy.iot_rule_national_policy.name
  target = var.IOT_CERT_ARN
}

resource "aws_iot_thing_principal_attachment" "rule_national_thing_att" {
  principal = var.IOT_CERT_ARN
  thing     = aws_iot_thing.rule_national.name
}
