resource "authentik_service_connection_kubernetes" "this" {
  name = var.name

  local      = var.local
  kubeconfig = var.kubeconfig != "" ? var.kubeconfig : null
  verify_ssl = var.verify_ssl
}
