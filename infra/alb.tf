module "http_sg" {
  source      = "./security_group"
  name        = "http-sg"
  vpc_id      = aws_vpc.current.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "./security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.current.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "http_redirect_sg" {
  source      = "./security_group"
  name        = "http-redirect-sg"
  vpc_id      = aws_vpc.current.id
  port        = 8080
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb" "current" {
  name                       = "current"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id
  ]

  /*
  access_logs {}
  */

  security_groups = [
    module.http_sg.security_group_id,
    module.https_sg.security_group_id,
    module.http_redirect_sg.security_group_id,
  ]


  tags = {
    Name = "${var.env}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.current.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "this is http"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "redirect_https" {
  load_balancer_arn = aws_lb.current.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port         = "443"
      protocol     = "HTTPS"
      status_code  = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.current.arn
  port            = "443"
  protocol        = "HTTPS"
  certificate_arn = aws_acm_certificate.current.arn
  ssl_policy      = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "this is httpsssss"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "current" {
  name                 = "current"
  target_type          = "ip"
  vpc_id               = aws_vpc.current.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200,404"
    port                = "traffic-port"
  }

  depends_on = [aws_lb.current]

  tags = {
    Name = "${var.env}"
  }
}

resource "aws_lb_listener_rule" "current" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.current.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

output "alb_dns_name" {
  value = aws_lb.current.dns_name
}

