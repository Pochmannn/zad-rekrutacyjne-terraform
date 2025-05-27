resource "aws_efs_file_system" "minio_efs" {
  creation_token = "minio-efs"
  encrypted      = true
}

resource "aws_efs_mount_target" "minio_efs_mt" {
  count = 2
  file_system_id  = aws_efs_file_system.minio_efs.id
  subnet_id       = element([aws_subnet.public_a.id, aws_subnet.public_b.id], count.index)
  security_groups = [aws_security_group.minio_sg.id]
}

