
variable "s3_bucket_name" {
  description = "Nazwa bucketu S3"
  type        = string
}

variable "minio_root_user" {
  description = "Login do MinIO"
  type        = string
}

variable "minio_root_password" {
  description = "Hasło do MinIO"
  type        = string
}

variable "aws_access_key" {
  description = "Access key AWS"
  type        = string
}

variable "aws_secret_key" {
  description = "Secret key AWS"
  type        = string
}

# variable "minio_url" {
#   description = "URL do minio"
#   type        = string
# }