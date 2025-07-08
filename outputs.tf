output "rds_hostname" {
  description = "RDS Instance Hostname"
  value       = aws_db_instance.fiapfood_db.address
  sensitive   = false
}

output "rds_port" {
  description = "RDS Instance Port"
  value       = aws_db_instance.fiapfood_db.port
  sensitive   = false
}

output "rds_username" {
  description = "RDS Instance Username"
  value       = aws_db_instance.fiapfood_db.username
  sensitive   = true
}

output "rds_password" {
  description = "RDS Instance Password"
  value       = aws_db_instance.fiapfood_db.password
  sensitive   = true
}

output "rds_endpoint" {
  description = "RDS Instance endpoint"
  value       = aws_db_instance.fiapfood_db.endpoint
}
