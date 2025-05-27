output "minio_url" {
  description = "Adres URL MinIO"
  value       = "${aws_lb.minio_alb.dns_name}:9000"
}

output "minio_root_user" {
  value = var.minio_root_user
}

output "minio_root_password" {
  value = var.minio_root_password
  sensitive = true
}

output "s3_bucket_name" {
  value = var.s3_bucket_name
}
