variable "name" {}
variable "policy" {}
variable "identifier" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["${var.identifier}"]
    }
  }
}

resource "aws_iam_policy" "current" {
  name   = "${var.name}"
  policy = "${var.policy}"
}

resource "aws_iam_role" "current" {
  name               = "${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "current" {
  role       = aws_iam_role.current.name
  policy_arn = aws_iam_policy.current.arn
}

output "iam_role_arn" {
  value = aws_iam_role.current.arn
}

