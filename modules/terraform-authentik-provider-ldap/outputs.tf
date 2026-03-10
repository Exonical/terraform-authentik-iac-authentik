output "id" {
  description = "The ID of the LDAP provider."
  value       = authentik_provider_ldap.this.id
}

output "name" {
  description = "The name of the LDAP provider."
  value       = authentik_provider_ldap.this.name
}
