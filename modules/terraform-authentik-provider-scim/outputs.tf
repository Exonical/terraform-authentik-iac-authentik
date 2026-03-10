output "id" {
  description = "The ID of the SCIM provider."
  value       = authentik_provider_scim.this.id
}

output "name" {
  description = "The name of the SCIM provider."
  value       = authentik_provider_scim.this.name
}
