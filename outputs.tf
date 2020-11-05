
output "lb_address" {
  value = module.alb.dns_address
}

output "database_endpoint" {
  value = module.database.database_endpoint
}

output "bucket_name" {
  value = module.s3_bucket.bucket_name
}
