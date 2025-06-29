variable "project_id" {
    description = "GCP project ID"    
    type        = string
}

variable "region" {
    description = "GCP region"
    default = "us-central1"
    type        = string
}

variable "zone" {
    description = "GCP zone"
    default     = "us-central1-a"
    type        = string
}

variable "db_name" {
    description = "Database name"
    type = string
}

variable "db_user" {
    description = "Username"
    type = string
    sensitive = true
}
variable "db_password" {
    description = "Password"
    type = string
    sensitive = true
}