# Create the IAM policy for Lambda execution
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-policy"
  description = "Policy for invoking Lambda function"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

# Attach the Lambda execution policy to the IAM role
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda-policy-attachment"
  roles      = [aws_iam_role.lambda_execution_role.name]
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Define the Lambda execution role
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  })
}