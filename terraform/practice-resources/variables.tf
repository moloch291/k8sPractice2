variable "namespace_name" {
  type        = string
  description = "Name of the new namespace"
}

variable "pod_name" {
  type        = string
  description = "Name of the pod"
}

variable "container_img" {
  type        = string
  description = "Container image name"
}

variable "container_port" {
  type        = number
  description = "Container port of the kuard pods"
}

variable "lp_http_get_path" {
  type        = string
  description = "Path of the http get liveness probe"
}

variable "lp_http_get_port" {
  type        = number
  description = "Port of the http get liveness probe"
}

variable "lp_time_conf" {
  type        = map(any)
  description = "Map for time config of liveness probe"
}

variable "rp_http_get_path" {
  type        = string
  description = "Path of the http get readiness probe"
}

variable "rp_http_get_port" {
  type        = number
  description = "Port of the http get readiness probe"
}

variable "rp_time_conf" {
  type        = map(any)
  description = "Map for time config of readiness probe"
}

variable "pod_resource_req" {
  type        = map(any)
  description = "Requested resources of the kuard pods"
}

variable "pod_resource_limit" {
  type        = map(any)
  description = "Resource limits of the kuard pods"
}
