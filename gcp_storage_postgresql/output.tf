// File: output.tf
# Outputs for the PostgreSQL instance
output "postgres_instance_connection_name" {
  value = google_sql_database_instance.postgres.connection_name
}


// Output the public IP address of the PostgreSQL instance
output "postgres_ip" {
  value = google_sql_database_instance.postgres.public_ip_address
}
