output "bucket_url" {
  value = "http://${google_storage_bucket.website.name}.storage.googleapis.com"
}