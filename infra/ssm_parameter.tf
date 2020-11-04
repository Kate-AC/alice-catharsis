resource "aws_ssm_parameter" "db_password" {
  name = "/db/password"
  value = "uninitialized"
  type = "SecureString"

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "mail_password" {
  name = "/mail/password"
  value = "uninitialized"
  type = "SecureString"

  lifecycle {
    ignore_changes = [value]
  }
}
