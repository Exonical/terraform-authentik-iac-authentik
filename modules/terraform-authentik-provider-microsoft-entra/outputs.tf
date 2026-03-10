output "id" {
  description = "The ID of the Microsoft Entra provider."
  value       = authentik_provider_microsoft_entra.this.id
}

output "name" {
  description = "The name of the Microsoft Entra provider."
  value       = authentik_provider_microsoft_entra.this.name
}
