output "id" {
  description = "The ID of the certificate key pair."
  value       = var.key_data != "" ? authentik_certificate_key_pair.this[0].id : authentik_certificate_key_pair.cert_only[0].id
}
