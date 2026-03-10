resource "authentik_provider_rac" "this" {
  name               = var.name
  authorization_flow = var.authorization_flow

  authentication_flow = var.authentication_flow != "" ? var.authentication_flow : null
  connection_expiry   = var.connection_expiry != "" ? var.connection_expiry : null
  settings            = var.settings != "" ? var.settings : null

  property_mappings = length(var.property_mappings) > 0 ? var.property_mappings : null
}
