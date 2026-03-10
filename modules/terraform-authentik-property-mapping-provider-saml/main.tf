resource "authentik_property_mapping_provider_saml" "this" {
  name       = var.name
  expression = var.expression
  saml_name  = var.saml_name

  friendly_name = var.friendly_name != "" ? var.friendly_name : null
}
