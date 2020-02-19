resource "aws_iam_role" "confluent_ssm" {
  name               = "CONFLUENT"
  description        = "Allows EC2 instances to call AWS services like CloudWatch and SSM on your behalf."
  assume_role_policy = data.aws_iam_policy_document.ssm.json
}

variable "roles" {
  type = list
  default = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
  "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  count      = length(var.roles)
  role       = aws_iam_role.confluent_ssm.name
  policy_arn = var.roles[count.index]
}

data "aws_iam_policy_document" "ssm" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:s3:::*"]

    principals {
      type = "Service"
      identifiers = [
        "s3.amazonaws.com",
        "ec2.amazonaws.com",
      "ssm.amazonaws.com"]
    }
  }

}
