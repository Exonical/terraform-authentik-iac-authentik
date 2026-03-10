resource "authentik_property_mapping_provider_scim" "this" {
  name       = var.name
  expression = var.expression
}
