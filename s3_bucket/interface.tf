variable "name" {
  type        = string
  description = "The name of the bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}


