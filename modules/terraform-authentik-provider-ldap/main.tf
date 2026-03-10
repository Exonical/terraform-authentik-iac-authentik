resource "authentik_provider_ldap" "this" {
  name        = var.name
  bind_flow   = var.bind_flow
  unbind_flow = var.unbind_flow
  base_dn     = var.base_dn

  search_mode     = var.search_mode
  bind_mode       = var.bind_mode
  mfa_support     = var.mfa_support
  tls_server_name = var.tls_server_name != "" ? var.tls_server_name : null
  certificate     = var.certificate != "" ? var.certificate : null

  gid_start_number = var.gid_start_number != 0 ? var.gid_start_number : null
  uid_start_number = var.uid_start_number != 0 ? var.uid_start_number : null
}
