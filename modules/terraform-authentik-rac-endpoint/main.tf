resource "authentik_rac_endpoint" "this" {
  name              = var.name
  host              = var.host
  protocol          = var.protocol
  protocol_provider = var.protocol_provider

  maximum_connections = var.maximum_connections
  property_mappings  = length(var.property_mappings) > 0 ? var.property_mappings : null
  settings           = var.settings != "" ? var.settings : null
}
