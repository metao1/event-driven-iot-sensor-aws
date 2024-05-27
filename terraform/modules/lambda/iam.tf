# Define the Lambda execution role
resource "aws_iam_role" "lambda_execute_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

# IAM Policy for Lambda logging
resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "lambda_logging_policy"
  description = "IAM policy for logging from a Lambda function"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_logging_policy_attachment" {
  role       = aws_iam_role.lambda_execute_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}

# Allow IoT to Invoke Lambda
resource "aws_lambda_permission" "allow_function_invoke" {
  statement_id  = "AllowExecutionFromIoT"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "iot.amazonaws.com"
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_execute_role.name
}

# Create the IAM policy for Lambda execution
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-policy"
  description = "Policy for invoking Lambda function"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

# Attach the Lambda execution policy to the IAM role
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda-policy-attachment"
  roles      = [aws_iam_role.lambda_execute_role.name]
  policy_arn = aws_iam_policy.lambda_policy.arn
}
