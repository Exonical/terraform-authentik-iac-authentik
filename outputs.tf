output "default_values" {
  description = "All default values."
  value       = local.defaults
}

output "model" {
  description = "Full model."
  value       = local.model
}

output "oauth2_client_secrets" {
  description = "Map of OAuth2 provider name -> client_secret. Includes Authentik-generated secrets for providers that omit client_secret in YAML, and pass-through values for those that supply one. Sensitive."
  value       = { for name, m in module.authentik_provider_oauth2 : name => m.client_secret }
  sensitive   = true
}