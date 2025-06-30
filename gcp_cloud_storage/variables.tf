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

variable "bucket_name" {
    description = "Name of the GCP Cloud Storage bucket"
    type        = string
  
}