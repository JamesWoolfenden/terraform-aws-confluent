resource "aws_iam_instance_profile" "confluent_ssm_profile" {
  name = "${var.environment}-CONFLUENT"
  role = aws_iam_role.confluent_ssm_role.name
}
