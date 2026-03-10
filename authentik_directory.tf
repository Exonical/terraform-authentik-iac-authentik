locals {
  dir_users            = try(local.directory.users, [])
  dir_groups           = try(local.directory.groups, [])
  dir_sources_ldap     = try(local.directory.sources.ldap, [])
  dir_sources_oauth    = try(local.directory.sources.oauth, [])
  dir_sources_saml     = try(local.directory.sources.saml, [])
  dir_sources_plex     = try(local.directory.sources.plex, [])
  dir_sources_kerberos = try(local.directory.sources.kerberos, [])
  dir_sources_scim     = try(local.directory.sources.scim, [])
}

# --- Users ---

module "authentik_user" {
  source   = "./modules/terraform-authentik-user"
  for_each = { for u in local.dir_users : u.username => u if local.modules.authentik_user == true && var.manage_directory }

  username = each.value.username
  name     = each.value.name

  email      = try(each.value.email, "")
  is_active  = try(each.value.is_active, local.defaults.authentik.directory.users.is_active, true)
  type       = try(each.value.type, local.defaults.authentik.directory.users.type, "internal")
  path       = try(each.value.path, "")
  password   = try(each.value.password, "")
  groups     = try(each.value.groups, [])
  attributes = try(each.value.attributes, "{}")
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
  for_each = { for s in local.dir_sources_ldap : s.slug => s if local.modules.authentik_source_ldap == true && var.manage_directory }

  name          = each.value.name
  slug          = each.value.slug
  server_uri    = each.value.server_uri
  bind_cn       = each.value.bind_cn
  bind_password = each.value.bind_password
  base_dn       = each.value.base_dn

  enabled                                = try(each.value.enabled, true)
  start_tls                              = try(each.value.start_tls, false)
  sni                                    = try(each.value.sni, false)
  sync_users                             = try(each.value.sync_users, true)
  sync_users_password                    = try(each.value.sync_users_password, true)
  sync_groups                            = try(each.value.sync_groups, true)
  delete_not_found_objects               = try(each.value.delete_not_found_objects, false)
  lookup_groups_from_user                = try(each.value.lookup_groups_from_user, true)
  password_login_update_internal_password = try(each.value.password_login_update_internal_password, false)
  additional_user_dn                     = try(each.value.additional_user_dn, "")
  additional_group_dn                    = try(each.value.additional_group_dn, "")
  user_object_filter                     = try(each.value.user_object_filter, "")
  group_object_filter                    = try(each.value.group_object_filter, "")
  group_membership_field                 = try(each.value.group_membership_field, "")
  user_membership_attribute              = try(each.value.user_membership_attribute, "")
  object_uniqueness_field                = try(each.value.object_uniqueness_field, "")
  user_path_template                     = try(each.value.user_path_template, "")
  sync_parent_group                      = try(each.value.sync_parent_group, "")
  sync_outgoing_trigger_mode             = try(each.value.sync_outgoing_trigger_mode, "")
  property_mappings                      = try(each.value.property_mappings, [])
  property_mappings_group                = try(each.value.property_mappings_group, [])
}

module "authentik_source_oauth" {
  source   = "./modules/terraform-authentik-source-oauth"
  for_each = { for s in local.dir_sources_oauth : s.slug => s if local.modules.authentik_source_oauth == true && var.manage_directory }

  name          = each.value.name
  slug          = each.value.slug
  provider_type = each.value.provider_type
  consumer_key  = each.value.consumer_key

  consumer_secret                = each.value.consumer_secret
  enabled                        = try(each.value.enabled, true)
  promoted                       = try(each.value.promoted, false)
  authentication_flow            = try(local.flow_map[each.value.authentication_flow], "")
  enrollment_flow                = try(local.flow_map[each.value.enrollment_flow], "")
  policy_engine_mode             = try(each.value.policy_engine_mode, "")
  user_matching_mode             = try(each.value.user_matching_mode, "")
  group_matching_mode            = try(each.value.group_matching_mode, "")
  user_path_template             = try(each.value.user_path_template, "")
  authorization_code_auth_method = try(each.value.authorization_code_auth_method, "")
  pkce                           = try(each.value.pkce, "")
  oidc_well_known_url            = try(each.value.oidc_well_known_url, "")
  oidc_jwks_url                  = try(each.value.oidc_jwks_url, "")
  oidc_jwks                      = try(each.value.oidc_jwks, "")
  authorization_url              = try(each.value.authorization_url, "")
  access_token_url               = try(each.value.access_token_url, "")
  profile_url                    = try(each.value.profile_url, "")
  request_token_url              = try(each.value.request_token_url, "")
  additional_scopes              = try(each.value.additional_scopes, "")
  property_mappings              = try(each.value.property_mappings, [])
  property_mappings_group        = try(each.value.property_mappings_group, [])
}

module "authentik_source_saml" {
  source   = "./modules/terraform-authentik-source-saml"
  for_each = { for s in local.dir_sources_saml : s.slug => s if local.modules.authentik_source_saml == true && var.manage_directory }

  name                    = each.value.name
  slug                    = each.value.slug
  sso_url                 = each.value.sso_url
  pre_authentication_flow = local.flow_map[each.value.pre_authentication_flow]

  enabled                     = try(each.value.enabled, true)
  promoted                    = try(each.value.promoted, false)
  authentication_flow         = try(local.flow_map[each.value.authentication_flow], "")
  enrollment_flow             = try(local.flow_map[each.value.enrollment_flow], "")
  policy_engine_mode          = try(each.value.policy_engine_mode, "")
  user_matching_mode          = try(each.value.user_matching_mode, "")
  group_matching_mode         = try(each.value.group_matching_mode, "")
  user_path_template          = try(each.value.user_path_template, "")
  issuer                      = try(each.value.issuer, "")
  metadata                    = try(each.value.metadata, "")
  slo_url                     = try(each.value.slo_url, "")
  binding_type                = try(each.value.binding_type, "")
  name_id_policy              = try(each.value.name_id_policy, "")
  digest_algorithm            = try(each.value.digest_algorithm, "")
  signature_algorithm         = try(each.value.signature_algorithm, "")
  signing_kp                  = try(each.value.signing_kp, "")
  verification_kp             = try(each.value.verification_kp, "")
  encryption_kp               = try(each.value.encryption_kp, "")
  allow_idp_initiated         = try(each.value.allow_idp_initiated, false)
  signed_assertion            = try(each.value.signed_assertion, false)
  signed_response             = try(each.value.signed_response, false)
  temporary_user_delete_after = try(each.value.temporary_user_delete_after, "")
  property_mappings           = try(each.value.property_mappings, [])
  property_mappings_group     = try(each.value.property_mappings_group, [])
}

module "authentik_source_plex" {
  source   = "./modules/terraform-authentik-source-plex"
  for_each = { for s in local.dir_sources_plex : s.slug => s if local.modules.authentik_source_plex == true && var.manage_directory }

  name       = each.value.name
  slug       = each.value.slug
  client_id  = each.value.client_id
  plex_token = each.value.plex_token

  enabled             = try(each.value.enabled, true)
  promoted            = try(each.value.promoted, false)
  allow_friends       = try(each.value.allow_friends, true)
  authentication_flow = try(local.flow_map[each.value.authentication_flow], "")
  enrollment_flow     = try(local.flow_map[each.value.enrollment_flow], "")
  policy_engine_mode  = try(each.value.policy_engine_mode, "")
  user_matching_mode  = try(each.value.user_matching_mode, "")
  group_matching_mode = try(each.value.group_matching_mode, "")
  user_path_template  = try(each.value.user_path_template, "")
  allowed_servers     = try(each.value.allowed_servers, [])
}

module "authentik_source_kerberos" {
  source   = "./modules/terraform-authentik-source-kerberos"
  for_each = { for s in local.dir_sources_kerberos : s.slug => s if local.modules.authentik_source_kerberos == true && var.manage_directory }

  name  = each.value.name
  slug  = each.value.slug
  realm = each.value.realm

  enabled                                = try(each.value.enabled, true)
  sync_users                             = try(each.value.sync_users, true)
  sync_users_password                    = try(each.value.sync_users_password, true)
  password_login_update_internal_password = try(each.value.password_login_update_internal_password, false)
  authentication_flow                    = try(local.flow_map[each.value.authentication_flow], "")
  enrollment_flow                        = try(local.flow_map[each.value.enrollment_flow], "")
  policy_engine_mode                     = try(each.value.policy_engine_mode, "")
  user_matching_mode                     = try(each.value.user_matching_mode, "")
  group_matching_mode                    = try(each.value.group_matching_mode, "")
  user_path_template                     = try(each.value.user_path_template, "")
  krb5_conf                              = try(each.value.krb5_conf, "")
  sync_principal                         = try(each.value.sync_principal, "")
  sync_password                          = try(each.value.sync_password, "")
  sync_keytab                            = try(each.value.sync_keytab, "")
  sync_ccache                            = try(each.value.sync_ccache, "")
  spnego_server_name                     = try(each.value.spnego_server_name, "")
  spnego_keytab                          = try(each.value.spnego_keytab, "")
  spnego_ccache                          = try(each.value.spnego_ccache, "")
  sync_outgoing_trigger_mode             = try(each.value.sync_outgoing_trigger_mode, "")
}

module "authentik_source_scim" {
  source   = "./modules/terraform-authentik-source-scim"
  for_each = { for s in local.dir_sources_scim : s.slug => s if local.modules.authentik_source_scim == true && var.manage_directory }

  name = each.value.name
  slug = each.value.slug

  enabled            = try(each.value.enabled, true)
  user_path_template = try(each.value.user_path_template, "")
  token              = try(each.value.token, "")
  property_mappings       = try(each.value.property_mappings, [])
  property_mappings_group = try(each.value.property_mappings_group, [])
}
