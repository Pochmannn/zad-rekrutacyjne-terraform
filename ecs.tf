resource "aws_ecs_cluster" "minio_cluster" {
  name = "minio-cluster"
}

resource "aws_ecs_task_definition" "minio_task" {
  family                   = "minio-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.minio_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name  = "minio",
      image = "quay.io/minio/minio:RELEASE.2025-04-22T22-12-26Z",
      portMappings = [
        {
          containerPort = 9000,
          hostPort      = 9000
        },
        {
          containerPort = 9001, 
          hostPort      = 9001
        }
      ],
      essential = true,
      environment = [
        {
          name  = "MINIO_ROOT_USER",
          value = var.minio_root_user
        },
        {
          name  = "MINIO_ROOT_PASSWORD",
          value = var.minio_root_password
        },

      ],
      command = ["server", "/data", "--console-address", ":9001"]
    }
  ])
}


resource "aws_ecs_service" "minio_service" {
  name            = "minio-service"
  cluster         = aws_ecs_cluster.minio_cluster.id
  task_definition = aws_ecs_task_definition.minio_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  health_check_grace_period_seconds  = 60
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50 

  network_configuration {
    subnets          = [aws_subnet.public_a.id,aws_subnet.public_b.id]
    security_groups  = [aws_security_group.minio_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.minio_api_tg.arn
    container_name   = "minio"
    container_port   = 9000
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.minio_console_tg.arn
    container_name   = "minio"
    container_port   = 9001
  }

  depends_on = [
    aws_lb_listener.minio_api_listener,
    aws_lb_listener.minio_console_listener,
  ]
}

