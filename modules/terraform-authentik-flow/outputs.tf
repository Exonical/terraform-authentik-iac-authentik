output "id" {
  description = "The ID of the flow."
  value       = authentik_flow.this.id
}

output "uuid" {
  description = "The UUID of the flow."
  value       = authentik_flow.this.uuid
}

output "slug" {
  description = "The slug of the flow."
  value       = authentik_flow.this.slug
}
