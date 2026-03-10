resource "authentik_property_mapping_source_kerberos" "this" {
  name       = var.name
  expression = var.expression
}
