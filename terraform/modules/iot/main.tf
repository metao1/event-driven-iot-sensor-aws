# IoT resources

### Rule - National
resource "aws_iot_thing" "iot_national" {
  name = var.iot_thing_name
}

resource "aws_iot_policy_attachment" "iot_national_policy" {
  policy = aws_iot_policy.iot_national_policy.name
  target = var.iot_cert_arn
}

resource "aws_iot_thing_principal_attachment" "iot_national_att" {
  principal = var.iot_cert_arn
  thing     = aws_iot_thing.iot_national.name
}
