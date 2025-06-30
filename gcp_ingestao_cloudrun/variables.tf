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

variable "image_url" {
    description = "URL da imagem do Docker no Artifact Registry ou Docker Hub"
    type        = string
}