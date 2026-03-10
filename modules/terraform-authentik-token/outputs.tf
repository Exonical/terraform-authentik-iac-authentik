output "id" {
  description = "The ID of the token."
  value       = authentik_token.this.id
}

output "key" {
  description = "The token key (only available if retrieve_key is true)."
  value       = authentik_token.this.key
  sensitive   = true
}
