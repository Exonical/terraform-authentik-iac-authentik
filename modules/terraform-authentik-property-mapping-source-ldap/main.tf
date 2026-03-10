resource "authentik_property_mapping_source_ldap" "this" {
  name       = var.name
  expression = var.expression
}
