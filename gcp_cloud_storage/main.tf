// Bucket com lifecycle rule para deletar objetos com mais de 30 dias
// Este bucket é usado para armazenar blobs

resource "google_storage_bucket" "ml_bucket" {
  name     = var.bucket_name
  location = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }
}
