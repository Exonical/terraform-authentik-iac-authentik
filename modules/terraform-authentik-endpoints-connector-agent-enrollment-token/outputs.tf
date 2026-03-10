output "id" {
  description = "The ID of the enrollment token."
  value       = authentik_endpoints_connector_agent_enrollment_token.this.id
}

output "key" {
  description = "The enrollment token key."
  value       = authentik_endpoints_connector_agent_enrollment_token.this.key
  sensitive   = true
}
