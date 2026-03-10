output "id" {
  description = "The ID of the SAML provider."
  value       = authentik_provider_saml.this.id
}

output "name" {
  description = "The name of the SAML provider."
  value       = authentik_provider_saml.this.name
}
