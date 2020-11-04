resource "aws_db_parameter_group" "current" {
  name   = "current"
  family = "mysql5.7"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"

  }

  tags = {
    Name = "${var.env}"
  }
}

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

resource "aws_db_subnet_group" "current" {
  name = "private"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_c.id
  ]

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_db_instance" "current" {
  identifier                 = "${var.env}-alice-catharsis"
  engine                     = "mysql"
  engine_version             = "5.7.25"
  instance_class             = "db.t2.micro"
  allocated_storage          = 20
  max_allocated_storage      = 100
  storage_type               = "gp2"
  storage_encrypted          = false
/*
  kms_key_id = asw_kms_key.current.arn
*/
  name                       = "${var.env}_alice_catharsis"
  username                   = "admin"
  password                   = "password"
  multi_az                   = true
  publicly_accessible        = false
  backup_window              = "09:10-09:40"
  backup_retention_period    = 30
  maintenance_window         = "mon:10:10-mon:10:40"
  auto_minor_version_upgrade = false
  deletion_protection        = true
  skip_final_snapshot        = true
  port                       = 19292
  apply_immediately          = false
  vpc_security_group_ids     = [
    module.mysql_sg.security_group_id
  ]
  parameter_group_name       = aws_db_parameter_group.current.name
  option_group_name          = aws_db_option_group.current.name
  db_subnet_group_name       = aws_db_subnet_group.current.name

  lifecycle {
    ignore_changes = [password]
  }

  tags = {
    Name = "${var.env}"
  }
}

module "mysql_sg" {
  source      = "./security_group"
  name        = "mysql-sg"
  vpc_id      = aws_vpc.current.id
  port        = 19292
  cidr_blocks = [
    aws_vpc.current.cidr_block,
    "176.32.78.57/32"
  ]
}

