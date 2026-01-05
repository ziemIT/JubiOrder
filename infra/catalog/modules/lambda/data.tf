data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

#NOTE: what if lambda should not have access to dynamodb at all?
data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:Scan"]
    #TODO: should be change to given dynamodb table
    resources = ["*"]
  }
}

data "archive_file" "func" {
  type        = "zip"
  source_dir = var.source_path
  output_path = "/tmp/${var.function_name}.zip"
}
