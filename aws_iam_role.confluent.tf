resource "aws_iam_role_policy" "confluent" {
  name = "${var.environment}-CONFLUENT"
  role = aws_iam_role.confluent_ssm_role.id

  policy = <<EOF
{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": ["s3:ListBucket"],
         "Resource": ["arn:aws:s3:::*"]
       },
       {
         "Effect": "Allow",
         "Action": [
           "s3:PutObject",
           "s3:ListObjects",
           "s3:GetObject"
         ],
         "Resource": "*"
       }
     ]
   }
EOF
}
