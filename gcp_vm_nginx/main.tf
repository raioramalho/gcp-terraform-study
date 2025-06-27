// VPC
resource "google_compute_network" "vpc_network" {
  name                    = "my-first-terraform-network"
  auto_create_subnetworks = false
  mtu = 1460
}

// VPC Subnetwork
resource "google_compute_subnetwork" "default" {
  name          = "my-first-terraform-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region       = var.region
  network      = google_compute_network.vpc_network.id
}

// Open Ssh in firewall

resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  direction = "INGRESS"
  network   = google_compute_network.vpc_network.id
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ssh-server"]  
}

// Open Http e Https in firewall
resource "google_compute_firewall" "http" {
  name = "allow-http-https"
  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }
  direction = "INGRESS"
  network   = google_compute_network.vpc_network.id
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["https-server"]  
}

// Single VM Instance
resource "google_compute_instance" "my_instance" {
  name = "my-first-terraform-instance"
  machine_type = "e2-micro"
  zone = var.zone

  tags = ["ssh-server", "https-server"] // Necessario para que o firewall funcione corretamente

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // Configuração de metadados para o script de inicialização
  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx

    # Cria o index.html a partir de conteúdo embutido
    cat <<EOT > /var/www/html/index.html
${replace(file("${path.module}/files/index.html"), "$", "\\$")}
EOT

    systemctl enable nginx
    systemctl restart nginx
  EOF


  network_interface {
    subnetwork = google_compute_subnetwork.default.id
    access_config {
      // Ephemeral IP
    }
  }

}