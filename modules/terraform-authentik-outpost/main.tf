resource "authentik_outpost" "this" {
  name               = var.name
  protocol_providers = var.protocol_providers

  type               = var.type != "" ? var.type : null
  service_connection = var.service_connection != "" ? var.service_connection : null
  config             = var.config != "" ? var.config : null
}
