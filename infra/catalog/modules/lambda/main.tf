resource "aws_iam_role" "func" {
  name               = var.function_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "policy" {
  name        = var.function_name
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.func.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_lambda_function" "func" {
  filename      = data.archive_file.func.output_path
  function_name = var.function_name
  role          = aws_iam_role.func.arn
  handler       = var.handler
  code_sha256   = data.archive_file.func.output_base64sha256

  runtime = var.runtime

  environment {
    variables = var.env_vars
  }
}
