# Define the IAM policy document for Lambda execution
data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.newsletter_function.arn]
  }
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

# Define the Lambda function
resource "aws_lambda_function" "newsletter_function" {
  function_name    = "iot-app-function"
  runtime          = "nodejs20.x"  # Update the runtime to nodejs20.x
  handler          = "app.newsletter"
  timeout          = 10  # Adjust based on the expected execution time of your function
  role             = aws_iam_role.lambda_execution_role.arn
  filename         = "iot-lambda-app.zip"
  source_code_hash = filebase64sha256("iot-lambda-app.zip")
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.newsletter_function.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.AWS_REGION}:${var.ACCOUNT_ID}:${aws_api_gateway_rest_api.newsletter_api.id}/Prod/GET${aws_api_gateway_resource.newsletter_resource.path}"
}

# Define the API Gateway resources
resource "aws_api_gateway_rest_api" "newsletter_api" {
  name        = "iot-app"
  description = "API Gateway for iot-app"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "newsletter_resource" {
  rest_api_id = aws_api_gateway_rest_api.newsletter_api.id
  parent_id   = aws_api_gateway_rest_api.newsletter_api.root_resource_id
  path_part   = "newsletter"
}

resource "aws_api_gateway_method" "newsletter_method" {
  rest_api_id   = aws_api_gateway_rest_api.newsletter_api.id
  resource_id   = aws_api_gateway_resource.newsletter_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Define the API Gateway integration
resource "aws_api_gateway_integration" "newsletter_integration" {
  rest_api_id             = aws_api_gateway_rest_api.newsletter_api.id
  resource_id             = aws_api_gateway_resource.newsletter_resource.id
  http_method             = aws_api_gateway_method.newsletter_method.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.AWS_REGION}:lambda:path/2015-03-31/functions/${aws_lambda_function.newsletter_function.arn}/invocations"
}

# Ensure that the Lambda function triggers on API Gateway deployment
resource "aws_api_gateway_deployment" "newsletter_deployment" {
  depends_on = [aws_api_gateway_integration.newsletter_integration]

  rest_api_id = aws_api_gateway_rest_api.newsletter_api.id
  stage_name  = "prod"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "apigateway.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_exec_policy" {
  name = "lambda_exec_policy"
  description = "Policy for Lambda execution"  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        Action: [
          "lambda:InvokeFunction"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_role_attach" {
  role = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_exec_policy.arn
}


