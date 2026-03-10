output "id" {
  description = "The ID of the OAuth source."
  value       = authentik_source_oauth.this.id
}

output "uuid" {
  description = "The UUID of the OAuth source."
  value       = authentik_source_oauth.this.uuid
}

output "callback_uri" {
  description = "The callback URI of the OAuth source."
  value       = authentik_source_oauth.this.callback_uri
}
