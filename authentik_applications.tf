locals {
  apps_list            = try(local.applications.applications, [])
  providers_oauth2     = try(local.applications.providers.oauth2, [])
  providers_saml       = try(local.applications.providers.saml, [])
  providers_proxy      = try(local.applications.providers.proxy, [])
  providers_ldap       = try(local.applications.providers.ldap, [])
  providers_radius     = try(local.applications.providers.radius, [])
  providers_scim       = try(local.applications.providers.scim, [])
  providers_rac        = try(local.applications.providers.rac, [])
  providers_google_workspace  = try(local.applications.providers.google_workspace, [])
  providers_microsoft_entra   = try(local.applications.providers.microsoft_entra, [])

  # Per-type name -> entry maps. for_each keys use only names (non-sensitive),
  # while config values flow through these maps so that sensitive fields like
  # client_secret / shared_secret / token retain their sensitivity marks
  # rather than tainting the for_each set.
  oauth2_provider_map           = { for p in local.providers_oauth2 : p.name => p }
  saml_provider_map             = { for p in local.providers_saml : p.name => p }
  proxy_provider_map            = { for p in local.providers_proxy : p.name => p }
  ldap_provider_map             = { for p in local.providers_ldap : p.name => p }
  radius_provider_map           = { for p in local.providers_radius : p.name => p }
  scim_provider_map             = { for p in local.providers_scim : p.name => p }
  rac_provider_map              = { for p in local.providers_rac : p.name => p }
  google_workspace_provider_map = { for p in local.providers_google_workspace : p.name => p }
  microsoft_entra_provider_map  = { for p in local.providers_microsoft_entra : p.name => p }

  # Build a map of provider name -> provider ID from all provider module outputs
  provider_id_map = merge(
    { for k, v in module.authentik_provider_oauth2 : k => v.id },
    { for k, v in module.authentik_provider_saml : k => v.id },
    { for k, v in module.authentik_provider_proxy : k => v.id },
    { for k, v in module.authentik_provider_ldap : k => v.id },
    { for k, v in module.authentik_provider_radius : k => v.id },
    { for k, v in module.authentik_provider_scim : k => v.id },
    { for k, v in module.authentik_provider_rac : k => v.id },
    { for k, v in module.authentik_provider_google_workspace : k => v.id },
    { for k, v in module.authentik_provider_microsoft_entra : k => v.id },
  )
}

# --- Providers ---

module "authentik_provider_oauth2" {
  source   = "./modules/terraform-authentik-provider-oauth2"
  for_each = local.modules.authentik_provider_oauth2 == true && var.manage_applications ? toset([for p in local.providers_oauth2 : p.name]) : []

  name               = each.key
  authorization_flow = local.flow_map[local.oauth2_provider_map[each.key].authorization_flow]
  invalidation_flow  = local.flow_map[local.oauth2_provider_map[each.key].invalidation_flow]
  client_id          = local.oauth2_provider_map[each.key].client_id

  client_type                = try(local.oauth2_provider_map[each.key].client_type, local.defaults.authentik.applications.providers.oauth2.client_type, "confidential")
  client_secret              = try(local.oauth2_provider_map[each.key].client_secret, "")
  include_claims_in_id_token = try(local.oauth2_provider_map[each.key].include_claims_in_id_token, local.defaults.authentik.applications.providers.oauth2.include_claims_in_id_token, true)
  issuer_mode                = try(local.oauth2_provider_map[each.key].issuer_mode, local.defaults.authentik.applications.providers.oauth2.issuer_mode, "per_provider")
  sub_mode                   = try(local.oauth2_provider_map[each.key].sub_mode, local.defaults.authentik.applications.providers.oauth2.sub_mode, "hashed_user_id")
  access_code_validity       = try(local.oauth2_provider_map[each.key].access_code_validity, local.defaults.authentik.applications.providers.oauth2.access_code_validity, "minutes=1")
  access_token_validity      = try(local.oauth2_provider_map[each.key].access_token_validity, local.defaults.authentik.applications.providers.oauth2.access_token_validity, "minutes=5")
  refresh_token_validity     = try(local.oauth2_provider_map[each.key].refresh_token_validity, local.defaults.authentik.applications.providers.oauth2.refresh_token_validity, "days=30")
  authentication_flow        = try(local.flow_map[local.oauth2_provider_map[each.key].authentication_flow], "")
  signing_key                = try(local.cert_map[local.oauth2_provider_map[each.key].signing_key], local.oauth2_provider_map[each.key].signing_key, "")
  encryption_key             = try(local.cert_map[local.oauth2_provider_map[each.key].encryption_key], local.oauth2_provider_map[each.key].encryption_key, "")
  logout_method              = try(local.oauth2_provider_map[each.key].logout_method, "")
  logout_uri                 = try(local.oauth2_provider_map[each.key].logout_uri, "")
  allowed_redirect_uris      = try(local.oauth2_provider_map[each.key].allowed_redirect_uris, [])
  property_mappings          = [for m in try(local.oauth2_provider_map[each.key].property_mappings, []) : try(local.pm_scope_map[m], m)]
  jwks_sources               = try(local.oauth2_provider_map[each.key].jwks_sources, [])
}

module "authentik_provider_saml" {
  source   = "./modules/terraform-authentik-provider-saml"
  for_each = local.modules.authentik_provider_saml == true && var.manage_applications ? toset([for p in local.providers_saml : p.name]) : []

  name               = each.key
  authorization_flow = local.flow_map[local.saml_provider_map[each.key].authorization_flow]
  invalidation_flow  = local.flow_map[local.saml_provider_map[each.key].invalidation_flow]
  acs_url            = local.saml_provider_map[each.key].acs_url

  assertion_valid_not_before      = try(local.saml_provider_map[each.key].assertion_valid_not_before, local.defaults.authentik.applications.providers.saml.assertion_valid_not_before, "minutes=-5")
  assertion_valid_not_on_or_after = try(local.saml_provider_map[each.key].assertion_valid_not_on_or_after, local.defaults.authentik.applications.providers.saml.assertion_valid_not_on_or_after, "minutes=5")
  session_valid_not_on_or_after   = try(local.saml_provider_map[each.key].session_valid_not_on_or_after, local.defaults.authentik.applications.providers.saml.session_valid_not_on_or_after, "minutes=86400")
  digest_algorithm                = try(local.saml_provider_map[each.key].digest_algorithm, local.defaults.authentik.applications.providers.saml.digest_algorithm, "http://www.w3.org/2001/04/xmlenc#sha256")
  signature_algorithm             = try(local.saml_provider_map[each.key].signature_algorithm, local.defaults.authentik.applications.providers.saml.signature_algorithm, "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256")
  audience                        = try(local.saml_provider_map[each.key].audience, "")
  issuer                          = try(local.saml_provider_map[each.key].issuer, "")
  authentication_flow             = try(local.flow_map[local.saml_provider_map[each.key].authentication_flow], "")
  sp_binding                      = try(local.saml_provider_map[each.key].sp_binding, "")
  signing_kp                      = try(local.cert_map[local.saml_provider_map[each.key].signing_kp], local.saml_provider_map[each.key].signing_kp, "")
  verification_kp                 = try(local.cert_map[local.saml_provider_map[each.key].verification_kp], local.saml_provider_map[each.key].verification_kp, "")
  encryption_kp                   = try(local.cert_map[local.saml_provider_map[each.key].encryption_kp], local.saml_provider_map[each.key].encryption_kp, "")
  name_id_mapping                 = try(local.saml_provider_map[each.key].name_id_mapping, "")
  default_relay_state             = try(local.saml_provider_map[each.key].default_relay_state, "")
  sls_url                         = try(local.saml_provider_map[each.key].sls_url, "")
  sls_binding                     = try(local.saml_provider_map[each.key].sls_binding, "")
  logout_method                   = try(local.saml_provider_map[each.key].logout_method, "")
  sign_assertion                  = try(local.saml_provider_map[each.key].sign_assertion, false)
  sign_response                   = try(local.saml_provider_map[each.key].sign_response, false)
  sign_logout_request             = try(local.saml_provider_map[each.key].sign_logout_request, false)
  property_mappings               = [for m in try(local.saml_provider_map[each.key].property_mappings, []) : try(local.pm_saml_map[m], m)]
}

module "authentik_provider_proxy" {
  source   = "./modules/terraform-authentik-provider-proxy"
  for_each = local.modules.authentik_provider_proxy == true && var.manage_applications ? toset([for p in local.providers_proxy : p.name]) : []

  name               = each.key
  authorization_flow = local.flow_map[local.proxy_provider_map[each.key].authorization_flow]
  invalidation_flow  = local.flow_map[local.proxy_provider_map[each.key].invalidation_flow]
  external_host      = local.proxy_provider_map[each.key].external_host

  internal_host                 = try(local.proxy_provider_map[each.key].internal_host, "")
  internal_host_ssl_validation  = try(local.proxy_provider_map[each.key].internal_host_ssl_validation, local.defaults.authentik.applications.providers.proxy.internal_host_ssl_validation, true)
  mode                          = try(local.proxy_provider_map[each.key].mode, "")
  authentication_flow           = try(local.flow_map[local.proxy_provider_map[each.key].authentication_flow], "")
  cookie_domain                 = try(local.proxy_provider_map[each.key].cookie_domain, "")
  access_token_validity         = try(local.proxy_provider_map[each.key].access_token_validity, "")
  refresh_token_validity        = try(local.proxy_provider_map[each.key].refresh_token_validity, "")
  skip_path_regex               = try(local.proxy_provider_map[each.key].skip_path_regex, "")
  basic_auth_enabled            = try(local.proxy_provider_map[each.key].basic_auth_enabled, false)
  basic_auth_username_attribute = try(local.proxy_provider_map[each.key].basic_auth_username_attribute, "")
  basic_auth_password_attribute = try(local.proxy_provider_map[each.key].basic_auth_password_attribute, "")
  intercept_header_auth         = try(local.proxy_provider_map[each.key].intercept_header_auth, true)
  property_mappings             = [for m in try(local.proxy_provider_map[each.key].property_mappings, []) : try(local.pm_scope_map[m], m)]
  jwks_sources                  = try(local.proxy_provider_map[each.key].jwks_sources, [])
}

module "authentik_provider_ldap" {
  source   = "./modules/terraform-authentik-provider-ldap"
  for_each = local.modules.authentik_provider_ldap == true && var.manage_applications ? toset([for p in local.providers_ldap : p.name]) : []

  name        = each.key
  bind_flow   = local.flow_map[local.ldap_provider_map[each.key].bind_flow]
  unbind_flow = local.flow_map[local.ldap_provider_map[each.key].unbind_flow]
  base_dn     = local.ldap_provider_map[each.key].base_dn

  search_mode      = try(local.ldap_provider_map[each.key].search_mode, local.defaults.authentik.applications.providers.ldap.search_mode, "direct")
  bind_mode        = try(local.ldap_provider_map[each.key].bind_mode, local.defaults.authentik.applications.providers.ldap.bind_mode, "direct")
  mfa_support      = try(local.ldap_provider_map[each.key].mfa_support, true)
  tls_server_name  = try(local.ldap_provider_map[each.key].tls_server_name, local.defaults.authentik.applications.providers.ldap.tls_server_name, "")
  certificate      = try(local.cert_map[local.ldap_provider_map[each.key].certificate], local.ldap_provider_map[each.key].certificate, "")
  gid_start_number = try(local.ldap_provider_map[each.key].gid_start_number, 0)
  uid_start_number = try(local.ldap_provider_map[each.key].uid_start_number, 0)
}

module "authentik_provider_radius" {
  source   = "./modules/terraform-authentik-provider-radius"
  for_each = local.modules.authentik_provider_radius == true && var.manage_applications ? toset([for p in local.providers_radius : p.name]) : []

  name               = each.key
  authorization_flow = local.flow_map[local.radius_provider_map[each.key].authorization_flow]
  invalidation_flow  = local.flow_map[local.radius_provider_map[each.key].invalidation_flow]
  shared_secret      = local.radius_provider_map[each.key].shared_secret

  mfa_support       = try(local.radius_provider_map[each.key].mfa_support, local.defaults.authentik.applications.providers.radius.mfa_support, true)
  client_networks   = try(local.radius_provider_map[each.key].client_networks, "")
  certificate       = try(local.cert_map[local.radius_provider_map[each.key].certificate], local.radius_provider_map[each.key].certificate, "")
  property_mappings = [for m in try(local.radius_provider_map[each.key].property_mappings, []) : try(local.pm_radius_map[m], m)]
}

module "authentik_provider_scim" {
  source   = "./modules/terraform-authentik-provider-scim"
  for_each = local.modules.authentik_provider_scim == true && var.manage_applications ? toset([for p in local.providers_scim : p.name]) : []

  name = each.key
  url  = local.scim_provider_map[each.key].url

  exclude_users_service_account = try(local.scim_provider_map[each.key].exclude_users_service_account, local.defaults.authentik.applications.providers.scim.exclude_users_service_account, false)
  token                         = try(local.scim_provider_map[each.key].token, "")
  filter_group                  = try(local.scim_provider_map[each.key].filter_group, "")
  property_mappings             = [for m in try(local.scim_provider_map[each.key].property_mappings, []) : try(local.pm_scim_map[m], m)]
  property_mappings_group       = [for m in try(local.scim_provider_map[each.key].property_mappings_group, []) : try(local.pm_scim_map[m], m)]
}

module "authentik_provider_rac" {
  source   = "./modules/terraform-authentik-provider-rac"
  for_each = local.modules.authentik_provider_rac == true && var.manage_applications ? toset([for p in local.providers_rac : p.name]) : []

  name               = each.key
  authorization_flow = local.flow_map[local.rac_provider_map[each.key].authorization_flow]

  authentication_flow = try(local.flow_map[local.rac_provider_map[each.key].authentication_flow], "")
  connection_expiry   = try(local.rac_provider_map[each.key].connection_expiry, "")
  settings            = try(local.rac_provider_map[each.key].settings, "")
  property_mappings   = [for m in try(local.rac_provider_map[each.key].property_mappings, []) : try(local.pm_rac_map[m], m)]
}

module "authentik_provider_google_workspace" {
  source   = "./modules/terraform-authentik-provider-google-workspace"
  for_each = local.modules.authentik_provider_google_workspace == true && var.manage_applications ? toset([for p in local.providers_google_workspace : p.name]) : []

  name                       = each.key
  default_group_email_domain = local.google_workspace_provider_map[each.key].default_group_email_domain

  credentials                   = try(local.google_workspace_provider_map[each.key].credentials, "")
  delegated_subject             = try(local.google_workspace_provider_map[each.key].delegated_subject, "")
  filter_group                  = try(local.google_workspace_provider_map[each.key].filter_group, "")
  user_delete_action            = try(local.google_workspace_provider_map[each.key].user_delete_action, "")
  group_delete_action           = try(local.google_workspace_provider_map[each.key].group_delete_action, "")
  dry_run                       = try(local.google_workspace_provider_map[each.key].dry_run, false)
  exclude_users_service_account = try(local.google_workspace_provider_map[each.key].exclude_users_service_account, false)
  property_mappings             = [for m in try(local.google_workspace_provider_map[each.key].property_mappings, []) : try(local.pm_scim_map[m], m)]
  property_mappings_group       = [for m in try(local.google_workspace_provider_map[each.key].property_mappings_group, []) : try(local.pm_scim_map[m], m)]
}

module "authentik_provider_microsoft_entra" {
  source   = "./modules/terraform-authentik-provider-microsoft-entra"
  for_each = local.modules.authentik_provider_microsoft_entra == true && var.manage_applications ? toset([for p in local.providers_microsoft_entra : p.name]) : []

  name          = each.key
  client_id     = local.microsoft_entra_provider_map[each.key].client_id
  client_secret = local.microsoft_entra_provider_map[each.key].client_secret
  tenant_id     = local.microsoft_entra_provider_map[each.key].tenant_id

  filter_group                  = try(local.microsoft_entra_provider_map[each.key].filter_group, "")
  user_delete_action            = try(local.microsoft_entra_provider_map[each.key].user_delete_action, "")
  group_delete_action           = try(local.microsoft_entra_provider_map[each.key].group_delete_action, "")
  dry_run                       = try(local.microsoft_entra_provider_map[each.key].dry_run, false)
  exclude_users_service_account = try(local.microsoft_entra_provider_map[each.key].exclude_users_service_account, false)
  property_mappings             = [for m in try(local.microsoft_entra_provider_map[each.key].property_mappings, []) : try(local.pm_scim_map[m], m)]
  property_mappings_group       = [for m in try(local.microsoft_entra_provider_map[each.key].property_mappings_group, []) : try(local.pm_scim_map[m], m)]
}

# --- Applications ---

module "authentik_application" {
  source   = "./modules/terraform-authentik-application"
  for_each = { for app in local.apps_list : app.slug => app if local.modules.authentik_application == true && var.manage_applications }

  name = each.value.name
  slug = each.value.slug

  protocol_provider     = try(local.provider_id_map[each.value.provider], 0)
  open_in_new_tab       = try(each.value.open_in_new_tab, local.defaults.authentik.applications.applications.open_in_new_tab, false)
  meta_launch_url       = try(each.value.meta_launch_url, "")
  meta_icon             = try(each.value.meta_icon, "")
  meta_description      = try(each.value.meta_description, "")
  meta_publisher        = try(each.value.meta_publisher, "")
  group                 = try(each.value.group, "")
  policy_engine_mode    = try(each.value.policy_engine_mode, "")
  backchannel_providers = try(each.value.backchannel_providers, [])

  depends_on = [
    module.authentik_provider_oauth2,
    module.authentik_provider_saml,
    module.authentik_provider_proxy,
    module.authentik_provider_ldap,
    module.authentik_provider_radius,
    module.authentik_provider_scim,
    module.authentik_provider_rac,
    module.authentik_provider_google_workspace,
    module.authentik_provider_microsoft_entra,
  ]
}
