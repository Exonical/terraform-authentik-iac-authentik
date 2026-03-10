resource "authentik_property_mapping_provider_google_workspace" "this" {
  name       = var.name
  expression = var.expression
}
