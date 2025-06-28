// VPC Personalizada
resource "google_compute_network" "vpc" {
  name                    = "wg-vpc"
  auto_create_subnetworks = false
}

// Sub-rede manual
resource "google_compute_subnetwork" "subnet" {
  name          = "wg-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "10.20.0.0/24"
}


// Firewall para permitir tráfego UDP na porta 51820 e 22
resource "google_compute_firewall" "allow_ssh_wireguard" {
  name    = "allow-ssh-wg"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "udp"
    ports    = ["51820"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}

// Instância de VM
resource "google_compute_instance" "wg_vm" {
  name         = "wg-vpn-server"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  tags = ["wireguard", "ssh"]

  metadata_startup_script = file("wireguard.sh")

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {}
  }

}
