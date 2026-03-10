resource "authentik_property_mapping_source_scim" "this" {
  name       = var.name
  expression = var.expression
}
