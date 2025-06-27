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
  target_tags = ["ssh"]  
}

// Single VM Instance
resource "google_compute_instance" "my_instance" {
  name = "my-first-terraform-instance"
  machine_type = "e2-micro"
  zone = var.zone


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install fastapi"

  network_interface {
    subnetwork = google_compute_subnetwork.default.id
    access_config {
      // Ephemeral IP
    }
  }

}