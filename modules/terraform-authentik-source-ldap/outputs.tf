output "id" {
  description = "The ID of the LDAP source."
  value       = authentik_source_ldap.this.id
}

output "uuid" {
  description = "The UUID of the LDAP source."
  value       = authentik_source_ldap.this.uuid
}
