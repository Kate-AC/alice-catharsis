resource "aws_s3_bucket" "public" {
  bucket = "public-${var.env}-alice-catharsis"
  acl    = "public-read"

  cors_rule {
    allowed_origins = ["https://alice-catharsis.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 300
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.public.id
  policy = data.aws_iam_policy_document.public.json
}


data "aws_iam_policy_document" "public" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.public.id}", "arn:aws:s3:::${aws_s3_bucket.public.id}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "alb_log" {
  bucket = "private-${var.env}-alb-log"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["582318560864"]
    }
  }
}

