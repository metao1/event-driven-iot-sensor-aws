data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "../iot-lambda-app" #TODO need to change this to remote repository  
  output_path = "iot-lambda-app.zip"
}

#Define the IAM policy document for Lambda execution
data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.iot_function.arn]
  }
}
