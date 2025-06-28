# VPC Personalizada
resource "google_compute_network" "k3s_vpc" {
  name                    = "k3s-vpc"
  auto_create_subnetworks = false
}

# Sub-rede
resource "google_compute_subnetwork" "k3s_subnet" {
  name          = "k3s-subnet"
  region        = var.region
  network       = google_compute_network.k3s_vpc.id
  ip_cidr_range = "10.20.0.0/24"
}

# Firewall: SSH (22), K3s API (6443)
resource "google_compute_firewall" "allow_k3s_traffic" {
  name    = "allow-k3s"
  network = google_compute_network.k3s_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "80", "443", "30080"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
}

# VM com K3s como Control Plane
resource "google_compute_instance" "k3s_control_plane" {
  name         = "k3s-control-plane"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  metadata_startup_script = file("k3s-server.sh")

  tags = ["k3s", "ssh"]

  network_interface {
    subnetwork    = google_compute_subnetwork.k3s_subnet.self_link
    access_config {} # IP público
  }
}
