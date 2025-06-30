output "bucket_url" {
  description = "URL do bucket"
  value       = "gs://${google_storage_bucket.ml_bucket.name}"
}
