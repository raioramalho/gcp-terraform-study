# Bucket para website estático
resource "google_storage_bucket" "website" {
    name                        = var.bucket_name
    location                    = "US"
    storage_class               = "STANDARD"

    uniform_bucket_level_access = true
    website {
        main_page_suffix = "index.html"
        not_found_page   = "404.html"
    }
}

# Upload do arquivo index.html
resource "google_storage_bucket_object" "index" {
    name         = "index.html"
    bucket       = google_storage_bucket.website.name
    content      = file("./website/index.html")
    content_type = "text/html"
}

# Upload do arquivo 404.html
resource "google_storage_bucket_object" "notfound" {
    name         = "404.html"
    bucket       = google_storage_bucket.website.name
    content      = file("./website/404.html")
    content_type = "text/html"
}

# Permitir acesso público a todos os objetos do bucket
resource "google_storage_bucket_iam_member" "public_access" {
    bucket = google_storage_bucket.website.name
    role   = "roles/storage.objectViewer"
    member = "allUsers"
}