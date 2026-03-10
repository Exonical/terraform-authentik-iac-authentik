output "id" {
  description = "The ID of the Kerberos source."
  value       = authentik_source_kerberos.this.id
}

output "uuid" {
  description = "The UUID of the Kerberos source."
  value       = authentik_source_kerberos.this.uuid
}
