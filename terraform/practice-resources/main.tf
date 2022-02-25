resource "kubernetes_namespace" "practice" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_replication_controller" "kuard_rc" {
  metadata {
    name      = "kuard-rc"
    namespace = "practice-ns"
    labels = {
      name = "kuard-rc"
    }
  }

  spec {
    selector = {
      name = var.pod_name
    }

    template {

      metadata {
        labels = {
          name = var.pod_name
        }
        annotations = {
          name = var.pod_name
        }
      }

      spec {

        container {
          image = var.container_img
          name  = var.pod_name

          port {
            container_port = var.container_port
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
              for k, v in var.pod_resource_req : k => v
            }
            limits = {
              for k, v in var.pod_resource_limit : k => v
            }
          }
        }
      }
    }

    replicas = 3

  }
}
