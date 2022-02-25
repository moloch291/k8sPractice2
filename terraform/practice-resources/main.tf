resource "kubernetes_namespace" "practice" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_pod" "kuard_pod" {

  metadata {
    name      = var.pod_name
    namespace = kubernetes_namespace.practice.metadata[0].name
  }

  spec {

    container {
      image = var.container_img
      name  = var.pod_name

      port {
        container_port = 8080
        name           = "http"
        protocol       = "TCP"
      }

      liveness_probe {
        http_get {
          path = var.lp_http_get_path
          port = var.lp_http_get_port
        }
        initial_delay_seconds = var.lp_time_conf.init_delay_sec
        timeout_seconds       = var.lp_time_conf.timeout_sec
        period_seconds        = var.lp_time_conf.period_sec
        failure_threshold     = var.lp_time_conf.failure_th
      }

      readiness_probe {
        http_get {
          path = var.rp_http_get_path
          port = var.rp_http_get_port
        }
        initial_delay_seconds = var.rp_time_conf.init_delay_sec
        timeout_seconds       = var.rp_time_conf.timeout_sec
      }

      resources {
        requests = {
          cpu    = "500m"
          memory = "128Mi"
        }
        limits = {
          cpu    = "1000m"
          memory = "256Mi"
        }
      }
    }
  }
}
