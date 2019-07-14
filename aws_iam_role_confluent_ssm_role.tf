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

resource "aws_iam_role_policy_attachment" "ssm-attach" {
  role = aws_iam_role.confluent_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "writetocloudwatch" {
  role = aws_iam_role.confluent_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  role = aws_iam_role.confluent_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
