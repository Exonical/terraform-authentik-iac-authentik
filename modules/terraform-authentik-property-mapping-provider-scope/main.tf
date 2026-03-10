resource "authentik_property_mapping_provider_scope" "this" {
  name       = var.name
  expression = var.expression
  scope_name = var.scope_name

  description = var.description != "" ? var.description : null
}
