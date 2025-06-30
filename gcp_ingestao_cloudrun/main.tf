// Criação do repositório (opcional se for usar imagem externa, como gcp-ingestao:alpine)
resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "gcp-ingestao"
  format        = "DOCKER"
}

// Criação do serviço Cloud Run com imagem do Docker Hub
resource "google_cloud_run_service" "gcp-ingestao" {
  name     = "gcp-ingestao-service"
  location = var.region

  template {
    spec {
      containers {
        image = "us.gcr.io/${var.project_id}/gcp_terraform_study-main:latest"
        ports {
          container_port = 80
        }
        resources {
          limits = {
            cpu    = "500m" // 0.5 CPU
            memory = "256Mi"
          }
        }
      }
    }
  }  
}

// IAM público para permitir acesso HTTP à função
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.gcp-ingestao.location
  service  = google_cloud_run_service.gcp-ingestao.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}