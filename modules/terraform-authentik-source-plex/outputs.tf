output "id" {
  description = "The ID of the Plex source."
  value       = authentik_source_plex.this.id
}

output "uuid" {
  description = "The UUID of the Plex source."
  value       = authentik_source_plex.this.uuid
}
