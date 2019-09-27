resource "aws_iam_role_policy" "confluent" {
  name   = "${var.environment}-CONFLUENT"
  role   = aws_iam_role.confluent_ssm_role.id
  policy = data.aws_iam_policy_document.confluent.json
}

data "aws_iam_policy_document" "confluent" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::*"]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:ListObjects",
    "s3:GetObject"]
    resources = ["*"]

  }
}
