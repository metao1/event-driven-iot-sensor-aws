# Define the Lambda function
resource "aws_lambda_function" "iot_function" {
  function_name    = var.lambda_function_name
  runtime          = "nodejs20.x"
  handler          = "app.iot_handler"
  timeout          = 10 # can be between 3 and 900 seconds
  role             = aws_iam_role.lambda_execution_role.arn
  filename         = data.archive_file.lambda_archive.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_archive.output_path)
}

# resource "aws_lambda_permission" "apigw" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.iot_function.arn
#   principal     = "lambda.amazonaws.com"
#   source_arn    = var.source_arn
# }`
