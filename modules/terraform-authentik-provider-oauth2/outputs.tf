output "id" {
  description = "The ID of the OAuth2 provider."
  value       = authentik_provider_oauth2.this.id
}

output "name" {
  description = "The name of the OAuth2 provider."
  value       = authentik_provider_oauth2.this.name
}
