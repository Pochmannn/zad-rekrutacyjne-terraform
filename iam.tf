resource "aws_iam_role" "minio_task_execution_role" {
  name = "minio-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}


# resource "aws_iam_policy" "minio_s3_access_policy" {
#   name = "minio-s3-access"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "s3:ListBucket",
#           "s3:GetObject",
#           "s3:PutObject",
#           "s3:DeleteObject"
#         ],
#         Resource = [
#           aws_s3_bucket.minio_remote_tier.arn,
#           "${aws_s3_bucket.minio_remote_tier.arn}/*"
#         ]
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "minio_attach" {
#   role       = aws_iam_role.minio_task_execution_role.name
#   policy_arn = aws_iam_policy.minio_s3_access_policy.arn
# }

