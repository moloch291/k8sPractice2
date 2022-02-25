provider "kubernetes" {
  config_path    = var.config_path
  config_context = var.config_context
}

module "practice-resources" {
  source           = "./practice-resources"
  namespace_name   = "practice-ns"
  pod_name         = "kuard-pod"
  container_img    = "gcr.io/kuar-demo/kuard-amd64:blue"
  container_port   = 8080
  lp_http_get_path = "/healthy"
  lp_http_get_port = 8080
  rp_http_get_path = "/ready"
  rp_http_get_port = 8080

  lp_time_conf = {
    init_delay_sec = 5
    timeout_sec    = 1
    period_sec     = 10
    failure_th     = 3
  }

  rp_time_conf = {
    init_delay_sec = 50
    timeout_sec    = 1
  }

  pod_resource_req = {
    cpu    = "500m"
    memory = "128Mi"
  }

  pod_resource_limit = {
    cpu    = "1000m"
    memory = "256Mi"
  }
}
