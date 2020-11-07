variable "env" {
  default     = "production"
  description = "Environment name."
}

variable "domain" {
  default = "alice-catharsis.com"
  description = "Base domain name."
}

/* 後で消す */
resource "aws_db_option_group" "current" {
  name                 = "current"
  engine_name          = "mysql"
  major_engine_version = "5.7"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"
  }

  tags = {
    Name = "${var.env}"
  }
}
