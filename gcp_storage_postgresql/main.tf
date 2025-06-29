// Instancia de banco de dados PostgreSQL no GCP
resource "google_sql_database_instance" "postgres" {
  name = "my-postgres-instance"
  region = var.region
  database_version = "POSTGRES_15"

  deletion_protection = false

  settings {
    tier = "db-f1-micro"  # Escolha o tipo de máquina conforme necessário   
    
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name = "default"
        value = "0.0.0.0/0" // Permitir acesso de qualquer IP (não recomendado para produção)
        }
    }
  }
}

// Configurando acesso ao banco de dados
resource "google_sql_user" "pg_user" {
  name     = var.db_user
  password = var.db_password
  instance = google_sql_database_instance.postgres.name
}

// Criando um banco de dados
resource "google_sql_database" "pg_db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres.name
}