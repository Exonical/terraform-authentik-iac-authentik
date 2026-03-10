resource "authentik_service_connection_docker" "this" {
  name = var.name

  local              = var.local
  url                = var.url != "" ? var.url : null
  tls_verification   = var.tls_verification != "" ? var.tls_verification : null
  tls_authentication = var.tls_authentication != "" ? var.tls_authentication : null
}
