output "id" {
  description = "The ID of the Google Workspace provider."
  value       = authentik_provider_google_workspace.this.id
}

output "name" {
  description = "The name of the Google Workspace provider."
  value       = authentik_provider_google_workspace.this.name
}
