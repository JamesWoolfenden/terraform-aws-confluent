data "aws_s3_bucket_object" "stunnel_cert" {
  bucket = "certificates-${data.aws_caller_identity.current.account_id}"
  key    = "stunnel/private.pem"
}


