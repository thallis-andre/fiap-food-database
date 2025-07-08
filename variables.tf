variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "db_username" {
  description = "RDS root username"
  default     = ""
  sensitive   = true
}

variable "db_password" {
  description = "RDS root password"
  default     = ""
  sensitive   = true
}
