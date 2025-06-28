// Criação do repositório (opcional se for usar imagem externa, como nginx:alpine)
resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "nginx"
  format        = "DOCKER"
}

// Criação do serviço Cloud Run com imagem do Docker Hub
resource "google_cloud_run_service" "nginx" {
  name     = "nginx-service"
  location = var.region

  template {
    spec {
      containers {
        image = "nginx:alpine" // imagem oficial do Docker Hub
        ports {
          container_port = 80
        }
        resources {
          limits = {
            cpu    = "1"
            memory = "128Mi"
          }
        }
      }
    }
  }  
}

// IAM público para permitir acesso HTTP à função
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.nginx.location
  service  = google_cloud_run_service.nginx.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}