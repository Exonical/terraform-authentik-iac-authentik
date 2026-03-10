output "id" {
  description = "The ID of the unique password policy."
  value       = authentik_policy_unique_password.this.id
}
