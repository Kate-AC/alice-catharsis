module "nginx_sg" {
  source      = "./security_group"
  name        = "nginx-sg"
  vpc_id      = aws_vpc.current.id
  port        = 80
  cidr_blocks = [aws_vpc.current.cidr_block]
}

resource "aws_ecs_cluster" "current" {
  name = "${var.env}-alice-catharsis"

  tags = {
    Name = "${var.env}"
  }
}

/*
resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./tasks/nginx.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

resource "aws_ecs_service" "nginx" {
  name                              = "nginx"
  cluster                           = aws_ecs_cluster.current.arn
  task_definition                   = aws_ecs_task_definition.nginx.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.nginx_sg.security_group_id]

    subnets = [
      aws_subnet.private_a.id,
      aws_subnet.private_c.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.current.arn
    container_name   = "nginx"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
*/

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = [
      "ssm:GetParameters",
      "kms:Decrypt",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./iam_role"
  name       = "CustomEcsTaskExecutionRole"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}

