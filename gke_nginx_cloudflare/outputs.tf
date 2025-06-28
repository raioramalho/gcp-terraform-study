output "nginx_external_ip" {
  value = kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip
}

output "nginx_url" {
  value = "https://${var.cloudflare_record_name}.${var.cloudflare_zone_name}"
}
