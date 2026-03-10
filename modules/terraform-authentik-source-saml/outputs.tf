output "id" {
  description = "The ID of the SAML source."
  value       = authentik_source_saml.this.id
}

output "uuid" {
  description = "The UUID of the SAML source."
  value       = authentik_source_saml.this.uuid
}
