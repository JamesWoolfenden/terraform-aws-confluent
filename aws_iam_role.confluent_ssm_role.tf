resource "aws_iam_role" "confluent_ssm_role" {
  name        = "${var.environment}-CONFLUENT"
  description = "Allows EC2 instances to call AWS services like CloudWatch and SSM on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "s3.amazonaws.com",
          "ec2.amazonaws.com",
          "ssm.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
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
  role       = aws_iam_role.confluent_ssm_role.name
  policy_arn = var.roles[count.index]
}
