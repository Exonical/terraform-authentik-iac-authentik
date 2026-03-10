resource "authentik_property_mapping_source_oauth" "this" {
  name       = var.name
  expression = var.expression
}
