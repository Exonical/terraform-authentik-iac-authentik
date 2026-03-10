output "id" {
  description = "The ID of the user."
  value       = authentik_user.this.id
}

output "username" {
  description = "The username."
  value       = authentik_user.this.username
}
