resource "aws_ecr_repository" "current" {
  name                 = "${var.env}-alice-catharsis-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.env}"
  }
}

