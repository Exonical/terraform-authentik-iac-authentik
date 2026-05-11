output "id" {
  description = "The ID of the OAuth2 provider."
  value       = authentik_provider_oauth2.this.id
}

output "name" {
  description = "The name of the OAuth2 provider."
  value       = authentik_provider_oauth2.this.name
}

output "client_secret" {
  description = "The client_secret of the OAuth2 provider (Authentik-generated when omitted from input)."
  value       = authentik_provider_oauth2.this.client_secret
  sensitive   = true
}
