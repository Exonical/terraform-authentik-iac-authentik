output "id" {
  description = "The ID of the application."
  value       = authentik_application.this.id
}

output "uuid" {
  description = "The UUID of the application."
  value       = authentik_application.this.uuid
}

output "name" {
  description = "The name of the application."
  value       = authentik_application.this.name
}
