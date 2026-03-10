resource "authentik_provider_radius" "this" {
  name               = var.name
  authorization_flow = var.authorization_flow
  invalidation_flow  = var.invalidation_flow
  shared_secret      = var.shared_secret

  mfa_support     = var.mfa_support
  client_networks = var.client_networks != "" ? var.client_networks : null
  certificate     = var.certificate != "" ? var.certificate : null

  property_mappings = length(var.property_mappings) > 0 ? var.property_mappings : null
}
