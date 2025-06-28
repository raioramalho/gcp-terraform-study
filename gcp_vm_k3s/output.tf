output "public_ip" {
  value = google_compute_instance.k3s_control_plane.network_interface[0].access_config[0].nat_ip
}
