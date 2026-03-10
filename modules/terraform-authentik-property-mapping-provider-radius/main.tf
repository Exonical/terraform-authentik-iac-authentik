resource "authentik_property_mapping_provider_radius" "this" {
  name       = var.name
  expression = var.expression
}
