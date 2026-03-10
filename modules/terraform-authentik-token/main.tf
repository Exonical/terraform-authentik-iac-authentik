resource "authentik_token" "this" {
  identifier = var.identifier
  user       = var.user

  description  = var.description != "" ? var.description : null
  intent       = var.intent != "" ? var.intent : null
  expiring     = var.expiring
  expires      = var.expires != "" ? var.expires : null
  retrieve_key = var.retrieve_key
}
