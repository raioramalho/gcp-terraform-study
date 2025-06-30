// Criando namespace
resource "kubernetes_namespace" "raiolab" {
  metadata {
    name = "raiolab"
  }
}

// Criando deployment do NGINX
resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.raiolab.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "us.gcr.io/estudos-464221/gcp-terraform-study-main:latest"
          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu = "500m"
              memory = "128Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "64Mi"
            }
          }
        }
      }
    }
  }
}

// Criando serviço do NGINX
resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.raiolab.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

// Configuração do Cloudflare
data "cloudflare_zones" "domain" {
  filter {
    name = var.cloudflare_zone_name
  }
}

// Criando registro DNS no Cloudflare
resource "cloudflare_record" "nginx" {

  // Garante que o serviço do NGINX esteja criado antes de criar o registro DNS
  depends_on = [kubernetes_service.nginx] 

  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.cloudflare_record_name
  content = kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip
  type    = "A"
  ttl     = 1
  proxied = true
}
