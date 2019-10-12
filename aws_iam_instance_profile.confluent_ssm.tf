resource "aws_iam_instance_profile" "confluent_ssm" {
  name = "CONFLUENT"
  role = aws_iam_role.confluent_ssm.name
}
