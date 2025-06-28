resource "kubernetes_namespace" "raiolab" {
  metadata {
    name = "raiolab"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.raiolab.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 2
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
          image = "nginx:1.25"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

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

data "cloudflare_zones" "domain" {
  filter {
    name = var.cloudflare_zone_name
  }
}

resource "cloudflare_record" "nginx" {
  depends_on = [kubernetes_service.nginx]

  zone_id = data.cloudflare_zones.domain.zones[0].id
  name    = var.cloudflare_record_name
  content = kubernetes_service.nginx.status[0].load_balancer[0].ingress[0].ip
  type    = "A"
  ttl     = 1
  proxied = true
}
