locals {
  dir_users            = try(local.directory.users, [])
  dir_groups           = try(local.directory.groups, [])
  dir_sources_ldap     = try(local.directory.sources.ldap, [])
  dir_sources_oauth    = try(local.directory.sources.oauth, [])
  dir_sources_saml     = try(local.directory.sources.saml, [])
  dir_sources_plex     = try(local.directory.sources.plex, [])
  dir_sources_kerberos = try(local.directory.sources.kerberos, [])
  dir_sources_scim     = try(local.directory.sources.scim, [])

  # Sensitive-safe lookup maps. for_each keys are slugs only (non-sensitive);
  # sensitive fields (bind_password, consumer_secret, plex_token, token) flow
  # through these maps without tainting the iteration set.
  source_ldap_map     = { for s in local.dir_sources_ldap : s.slug => s }
  source_oauth_map    = { for s in local.dir_sources_oauth : s.slug => s }
  source_saml_map     = { for s in local.dir_sources_saml : s.slug => s }
  source_plex_map     = { for s in local.dir_sources_plex : s.slug => s }
  source_kerberos_map = { for s in local.dir_sources_kerberos : s.slug => s }
  source_scim_map     = { for s in local.dir_sources_scim : s.slug => s }

  # User map for sensitive-safe for_each (password is sensitive).
  user_map = { for u in local.dir_users : u.username => u }
}

# --- Users ---

module "authentik_user" {
  source   = "./modules/terraform-authentik-user"
  for_each = local.modules.authentik_user == true && var.manage_directory ? toset([for u in local.dir_users : u.username]) : []

  username = each.key
  name     = local.user_map[each.key].name

  email      = try(local.user_map[each.key].email, "")
  is_active  = try(local.user_map[each.key].is_active, local.defaults.authentik.directory.users.is_active, true)
  type       = try(local.user_map[each.key].type, local.defaults.authentik.directory.users.type, "internal")
  path       = try(local.user_map[each.key].path, "")
  password   = try(local.user_map[each.key].password, "")
  groups     = try(local.user_map[each.key].groups, [])
  attributes = try(local.user_map[each.key].attributes, "{}")
}

# --- Groups ---

module "authentik_group" {
  source   = "./modules/terraform-authentik-group"
  for_each = { for g in local.dir_groups : g.name => g if local.modules.authentik_group == true && var.manage_directory }

  name = each.value.name

  is_superuser = try(each.value.is_superuser, local.defaults.authentik.directory.groups.is_superuser, false)
  parents      = try(each.value.parents, [])
  users        = try(each.value.users, [])
  roles        = try(each.value.roles, [])
  attributes   = try(each.value.attributes, "{}")
}

# --- Sources ---

module "authentik_source_ldap" {
  source   = "./modules/terraform-authentik-source-ldap"
  for_each = local.modules.authentik_source_ldap == true && var.manage_directory ? toset([for s in local.dir_sources_ldap : s.slug]) : []

  name          = local.source_ldap_map[each.key].name
  slug          = each.key
  server_uri    = local.source_ldap_map[each.key].server_uri
  bind_cn       = local.source_ldap_map[each.key].bind_cn
  bind_password = local.source_ldap_map[each.key].bind_password
  base_dn       = local.source_ldap_map[each.key].base_dn

  enabled                                = try(local.source_ldap_map[each.key].enabled, true)
  start_tls                              = try(local.source_ldap_map[each.key].start_tls, false)
  sni                                    = try(local.source_ldap_map[each.key].sni, false)
  sync_users                             = try(local.source_ldap_map[each.key].sync_users, true)
  sync_users_password                    = try(local.source_ldap_map[each.key].sync_users_password, true)
  sync_groups                            = try(local.source_ldap_map[each.key].sync_groups, true)
  delete_not_found_objects               = try(local.source_ldap_map[each.key].delete_not_found_objects, false)
  lookup_groups_from_user                = try(local.source_ldap_map[each.key].lookup_groups_from_user, true)
  password_login_update_internal_password = try(local.source_ldap_map[each.key].password_login_update_internal_password, false)
  additional_user_dn                     = try(local.source_ldap_map[each.key].additional_user_dn, "")
  additional_group_dn                    = try(local.source_ldap_map[each.key].additional_group_dn, "")
  user_object_filter                     = try(local.source_ldap_map[each.key].user_object_filter, "")
  group_object_filter                    = try(local.source_ldap_map[each.key].group_object_filter, "")
  group_membership_field                 = try(local.source_ldap_map[each.key].group_membership_field, "")
  user_membership_attribute              = try(local.source_ldap_map[each.key].user_membership_attribute, "")
  object_uniqueness_field                = try(local.source_ldap_map[each.key].object_uniqueness_field, "")
  user_path_template                     = try(local.source_ldap_map[each.key].user_path_template, "")
  sync_parent_group                      = try(local.source_ldap_map[each.key].sync_parent_group, "")
  sync_outgoing_trigger_mode             = try(local.source_ldap_map[each.key].sync_outgoing_trigger_mode, "")
  property_mappings                      = [for m in try(local.source_ldap_map[each.key].property_mappings, []) : try(local.pm_source_map[m], m)]
  property_mappings_group                = [for m in try(local.source_ldap_map[each.key].property_mappings_group, []) : try(local.pm_source_map[m], m)]
}

module "authentik_source_oauth" {
  source   = "./modules/terraform-authentik-source-oauth"
  for_each = local.modules.authentik_source_oauth == true && var.manage_directory ? toset([for s in local.dir_sources_oauth : s.slug]) : []

  name          = local.source_oauth_map[each.key].name
  slug          = each.key
  provider_type = local.source_oauth_map[each.key].provider_type
  consumer_key  = local.source_oauth_map[each.key].consumer_key

  consumer_secret                = local.source_oauth_map[each.key].consumer_secret
  enabled                        = try(local.source_oauth_map[each.key].enabled, true)
  promoted                       = try(local.source_oauth_map[each.key].promoted, false)
  authentication_flow            = try(local.flow_map[local.source_oauth_map[each.key].authentication_flow], "")
  enrollment_flow                = try(local.flow_map[local.source_oauth_map[each.key].enrollment_flow], "")
  policy_engine_mode             = try(local.source_oauth_map[each.key].policy_engine_mode, "")
  user_matching_mode             = try(local.source_oauth_map[each.key].user_matching_mode, "")
  group_matching_mode            = try(local.source_oauth_map[each.key].group_matching_mode, "")
  user_path_template             = try(local.source_oauth_map[each.key].user_path_template, "")
  authorization_code_auth_method = try(local.source_oauth_map[each.key].authorization_code_auth_method, "")
  pkce                           = try(local.source_oauth_map[each.key].pkce, "")
  oidc_well_known_url            = try(local.source_oauth_map[each.key].oidc_well_known_url, "")
  oidc_jwks_url                  = try(local.source_oauth_map[each.key].oidc_jwks_url, "")
  oidc_jwks                      = try(local.source_oauth_map[each.key].oidc_jwks, "")
  authorization_url              = try(local.source_oauth_map[each.key].authorization_url, "")
  access_token_url               = try(local.source_oauth_map[each.key].access_token_url, "")
  profile_url                    = try(local.source_oauth_map[each.key].profile_url, "")
  request_token_url              = try(local.source_oauth_map[each.key].request_token_url, "")
  additional_scopes              = try(local.source_oauth_map[each.key].additional_scopes, "")
  property_mappings              = [for m in try(local.source_oauth_map[each.key].property_mappings, []) : try(local.pm_source_map[m], m)]
  property_mappings_group        = [for m in try(local.source_oauth_map[each.key].property_mappings_group, []) : try(local.pm_source_map[m], m)]
}

module "authentik_source_saml" {
  source   = "./modules/terraform-authentik-source-saml"
  for_each = local.modules.authentik_source_saml == true && var.manage_directory ? toset([for s in local.dir_sources_saml : s.slug]) : []

  name                    = local.source_saml_map[each.key].name
  slug                    = each.key
  sso_url                 = local.source_saml_map[each.key].sso_url
  pre_authentication_flow = local.flow_map[local.source_saml_map[each.key].pre_authentication_flow]

  enabled                     = try(local.source_saml_map[each.key].enabled, true)
  promoted                    = try(local.source_saml_map[each.key].promoted, false)
  authentication_flow         = try(local.flow_map[local.source_saml_map[each.key].authentication_flow], "")
  enrollment_flow             = try(local.flow_map[local.source_saml_map[each.key].enrollment_flow], "")
  policy_engine_mode          = try(local.source_saml_map[each.key].policy_engine_mode, "")
  user_matching_mode          = try(local.source_saml_map[each.key].user_matching_mode, "")
  group_matching_mode         = try(local.source_saml_map[each.key].group_matching_mode, "")
  user_path_template          = try(local.source_saml_map[each.key].user_path_template, "")
  issuer                      = try(local.source_saml_map[each.key].issuer, "")
  metadata                    = try(local.source_saml_map[each.key].metadata, "")
  slo_url                     = try(local.source_saml_map[each.key].slo_url, "")
  binding_type                = try(local.source_saml_map[each.key].binding_type, "")
  name_id_policy              = try(local.source_saml_map[each.key].name_id_policy, "")
  digest_algorithm            = try(local.source_saml_map[each.key].digest_algorithm, "")
  signature_algorithm         = try(local.source_saml_map[each.key].signature_algorithm, "")
  signing_kp                  = try(local.cert_map[local.source_saml_map[each.key].signing_kp], local.source_saml_map[each.key].signing_kp, "")
  verification_kp             = try(local.cert_map[local.source_saml_map[each.key].verification_kp], local.source_saml_map[each.key].verification_kp, "")
  encryption_kp               = try(local.cert_map[local.source_saml_map[each.key].encryption_kp], local.source_saml_map[each.key].encryption_kp, "")
  allow_idp_initiated         = try(local.source_saml_map[each.key].allow_idp_initiated, false)
  signed_assertion            = try(local.source_saml_map[each.key].signed_assertion, false)
  signed_response             = try(local.source_saml_map[each.key].signed_response, false)
  temporary_user_delete_after = try(local.source_saml_map[each.key].temporary_user_delete_after, "")
  property_mappings           = [for m in try(local.source_saml_map[each.key].property_mappings, []) : try(local.pm_source_map[m], m)]
  property_mappings_group     = [for m in try(local.source_saml_map[each.key].property_mappings_group, []) : try(local.pm_source_map[m], m)]
}

module "authentik_source_plex" {
  source   = "./modules/terraform-authentik-source-plex"
  for_each = local.modules.authentik_source_plex == true && var.manage_directory ? toset([for s in local.dir_sources_plex : s.slug]) : []

  name       = local.source_plex_map[each.key].name
  slug       = each.key
  client_id  = local.source_plex_map[each.key].client_id
  plex_token = local.source_plex_map[each.key].plex_token

  enabled             = try(local.source_plex_map[each.key].enabled, true)
  promoted            = try(local.source_plex_map[each.key].promoted, false)
  allow_friends       = try(local.source_plex_map[each.key].allow_friends, true)
  authentication_flow = try(local.flow_map[local.source_plex_map[each.key].authentication_flow], "")
  enrollment_flow     = try(local.flow_map[local.source_plex_map[each.key].enrollment_flow], "")
  policy_engine_mode  = try(local.source_plex_map[each.key].policy_engine_mode, "")
  user_matching_mode  = try(local.source_plex_map[each.key].user_matching_mode, "")
  group_matching_mode = try(local.source_plex_map[each.key].group_matching_mode, "")
  user_path_template  = try(local.source_plex_map[each.key].user_path_template, "")
  allowed_servers     = try(local.source_plex_map[each.key].allowed_servers, [])
}

module "authentik_source_kerberos" {
  source   = "./modules/terraform-authentik-source-kerberos"
  for_each = local.modules.authentik_source_kerberos == true && var.manage_directory ? toset([for s in local.dir_sources_kerberos : s.slug]) : []

  name  = local.source_kerberos_map[each.key].name
  slug  = each.key
  realm = local.source_kerberos_map[each.key].realm

  enabled                                = try(local.source_kerberos_map[each.key].enabled, true)
  sync_users                             = try(local.source_kerberos_map[each.key].sync_users, true)
  sync_users_password                    = try(local.source_kerberos_map[each.key].sync_users_password, true)
  password_login_update_internal_password = try(local.source_kerberos_map[each.key].password_login_update_internal_password, false)
  authentication_flow                    = try(local.flow_map[local.source_kerberos_map[each.key].authentication_flow], "")
  enrollment_flow                        = try(local.flow_map[local.source_kerberos_map[each.key].enrollment_flow], "")
  policy_engine_mode                     = try(local.source_kerberos_map[each.key].policy_engine_mode, "")
  user_matching_mode                     = try(local.source_kerberos_map[each.key].user_matching_mode, "")
  group_matching_mode                    = try(local.source_kerberos_map[each.key].group_matching_mode, "")
  user_path_template                     = try(local.source_kerberos_map[each.key].user_path_template, "")
  krb5_conf                              = try(local.source_kerberos_map[each.key].krb5_conf, "")
  sync_principal                         = try(local.source_kerberos_map[each.key].sync_principal, "")
  sync_password                          = try(local.source_kerberos_map[each.key].sync_password, "")
  sync_keytab                            = try(local.source_kerberos_map[each.key].sync_keytab, "")
  sync_ccache                            = try(local.source_kerberos_map[each.key].sync_ccache, "")
  spnego_server_name                     = try(local.source_kerberos_map[each.key].spnego_server_name, "")
  spnego_keytab                          = try(local.source_kerberos_map[each.key].spnego_keytab, "")
  spnego_ccache                          = try(local.source_kerberos_map[each.key].spnego_ccache, "")
  sync_outgoing_trigger_mode             = try(local.source_kerberos_map[each.key].sync_outgoing_trigger_mode, "")
}

module "authentik_source_scim" {
  source   = "./modules/terraform-authentik-source-scim"
  for_each = local.modules.authentik_source_scim == true && var.manage_directory ? toset([for s in local.dir_sources_scim : s.slug]) : []

  name = local.source_scim_map[each.key].name
  slug = each.key

  enabled            = try(local.source_scim_map[each.key].enabled, true)
  user_path_template = try(local.source_scim_map[each.key].user_path_template, "")
  token              = try(local.source_scim_map[each.key].token, "")
  property_mappings       = [for m in try(local.source_scim_map[each.key].property_mappings, []) : try(local.pm_source_map[m], m)]
  property_mappings_group = [for m in try(local.source_scim_map[each.key].property_mappings_group, []) : try(local.pm_source_map[m], m)]
}
