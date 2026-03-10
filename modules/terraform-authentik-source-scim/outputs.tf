output "id" {
  description = "The ID of the SCIM source."
  value       = authentik_source_scim.this.id
}

output "uuid" {
  description = "The UUID of the SCIM source."
  value       = authentik_source_scim.this.uuid
}

output "scim_url" {
  description = "The SCIM URL of the source."
  value       = authentik_source_scim.this.scim_url
}

output "token" {
  description = "The token for the SCIM source."
  value       = authentik_source_scim.this.token
  sensitive   = true
}
