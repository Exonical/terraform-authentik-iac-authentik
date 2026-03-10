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
  for_each = { for p in local.providers_oauth2 : p.name => p if local.modules.authentik_provider_oauth2 == true && var.manage_applications }

  name               = each.value.name
  authorization_flow = local.flow_map[each.value.authorization_flow]
  invalidation_flow  = local.flow_map[each.value.invalidation_flow]
  client_id          = each.value.client_id

  client_type                = try(each.value.client_type, local.defaults.authentik.applications.providers.oauth2.client_type, "confidential")
  client_secret              = try(each.value.client_secret, "")
  include_claims_in_id_token = try(each.value.include_claims_in_id_token, local.defaults.authentik.applications.providers.oauth2.include_claims_in_id_token, true)
  issuer_mode                = try(each.value.issuer_mode, local.defaults.authentik.applications.providers.oauth2.issuer_mode, "per_provider")
  sub_mode                   = try(each.value.sub_mode, local.defaults.authentik.applications.providers.oauth2.sub_mode, "hashed_user_id")
  access_code_validity       = try(each.value.access_code_validity, local.defaults.authentik.applications.providers.oauth2.access_code_validity, "minutes=1")
  access_token_validity      = try(each.value.access_token_validity, local.defaults.authentik.applications.providers.oauth2.access_token_validity, "minutes=5")
  refresh_token_validity     = try(each.value.refresh_token_validity, local.defaults.authentik.applications.providers.oauth2.refresh_token_validity, "days=30")
  authentication_flow        = try(local.flow_map[each.value.authentication_flow], "")
  signing_key                = try(each.value.signing_key, "")
  encryption_key             = try(each.value.encryption_key, "")
  logout_method              = try(each.value.logout_method, "")
  logout_uri                 = try(each.value.logout_uri, "")
  allowed_redirect_uris      = try(each.value.allowed_redirect_uris, [])
  property_mappings          = try(each.value.property_mappings, [])
  jwks_sources               = try(each.value.jwks_sources, [])
}

module "authentik_provider_saml" {
  source   = "./modules/terraform-authentik-provider-saml"
  for_each = { for p in local.providers_saml : p.name => p if local.modules.authentik_provider_saml == true && var.manage_applications }

  name               = each.value.name
  authorization_flow = local.flow_map[each.value.authorization_flow]
  invalidation_flow  = local.flow_map[each.value.invalidation_flow]
  acs_url            = each.value.acs_url

  assertion_valid_not_before      = try(each.value.assertion_valid_not_before, local.defaults.authentik.applications.providers.saml.assertion_valid_not_before, "minutes=-5")
  assertion_valid_not_on_or_after = try(each.value.assertion_valid_not_on_or_after, local.defaults.authentik.applications.providers.saml.assertion_valid_not_on_or_after, "minutes=5")
  session_valid_not_on_or_after   = try(each.value.session_valid_not_on_or_after, local.defaults.authentik.applications.providers.saml.session_valid_not_on_or_after, "minutes=86400")
  digest_algorithm                = try(each.value.digest_algorithm, local.defaults.authentik.applications.providers.saml.digest_algorithm, "http://www.w3.org/2001/04/xmlenc#sha256")
  signature_algorithm             = try(each.value.signature_algorithm, local.defaults.authentik.applications.providers.saml.signature_algorithm, "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256")
  audience                        = try(each.value.audience, "")
  issuer                          = try(each.value.issuer, "")
  authentication_flow             = try(local.flow_map[each.value.authentication_flow], "")
  sp_binding                      = try(each.value.sp_binding, "")
  signing_kp                      = try(each.value.signing_kp, "")
  verification_kp                 = try(each.value.verification_kp, "")
  encryption_kp                   = try(each.value.encryption_kp, "")
  name_id_mapping                 = try(each.value.name_id_mapping, "")
  default_relay_state             = try(each.value.default_relay_state, "")
  sls_url                         = try(each.value.sls_url, "")
  sls_binding                     = try(each.value.sls_binding, "")
  logout_method                   = try(each.value.logout_method, "")
  sign_assertion                  = try(each.value.sign_assertion, false)
  sign_response                   = try(each.value.sign_response, false)
  sign_logout_request             = try(each.value.sign_logout_request, false)
  property_mappings               = try(each.value.property_mappings, [])
}

module "authentik_provider_proxy" {
  source   = "./modules/terraform-authentik-provider-proxy"
  for_each = { for p in local.providers_proxy : p.name => p if local.modules.authentik_provider_proxy == true && var.manage_applications }

  name               = each.value.name
  authorization_flow = local.flow_map[each.value.authorization_flow]
  invalidation_flow  = local.flow_map[each.value.invalidation_flow]
  external_host      = each.value.external_host

  internal_host                 = try(each.value.internal_host, "")
  internal_host_ssl_validation  = try(each.value.internal_host_ssl_validation, local.defaults.authentik.applications.providers.proxy.internal_host_ssl_validation, true)
  mode                          = try(each.value.mode, "")
  authentication_flow           = try(local.flow_map[each.value.authentication_flow], "")
  cookie_domain                 = try(each.value.cookie_domain, "")
  access_token_validity         = try(each.value.access_token_validity, "")
  refresh_token_validity        = try(each.value.refresh_token_validity, "")
  skip_path_regex               = try(each.value.skip_path_regex, "")
  basic_auth_enabled            = try(each.value.basic_auth_enabled, false)
  basic_auth_username_attribute = try(each.value.basic_auth_username_attribute, "")
  basic_auth_password_attribute = try(each.value.basic_auth_password_attribute, "")
  intercept_header_auth         = try(each.value.intercept_header_auth, true)
  property_mappings             = try(each.value.property_mappings, [])
  jwks_sources                  = try(each.value.jwks_sources, [])
}

module "authentik_provider_ldap" {
  source   = "./modules/terraform-authentik-provider-ldap"
  for_each = { for p in local.providers_ldap : p.name => p if local.modules.authentik_provider_ldap == true && var.manage_applications }

  name        = each.value.name
  bind_flow   = local.flow_map[each.value.bind_flow]
  unbind_flow = local.flow_map[each.value.unbind_flow]
  base_dn     = each.value.base_dn

  search_mode      = try(each.value.search_mode, local.defaults.authentik.applications.providers.ldap.search_mode, "direct")
  bind_mode        = try(each.value.bind_mode, local.defaults.authentik.applications.providers.ldap.bind_mode, "direct")
  mfa_support      = try(each.value.mfa_support, true)
  tls_server_name  = try(each.value.tls_server_name, local.defaults.authentik.applications.providers.ldap.tls_server_name, "")
  certificate      = try(each.value.certificate, "")
  gid_start_number = try(each.value.gid_start_number, 0)
  uid_start_number = try(each.value.uid_start_number, 0)
}

module "authentik_provider_radius" {
  source   = "./modules/terraform-authentik-provider-radius"
  for_each = { for p in local.providers_radius : p.name => p if local.modules.authentik_provider_radius == true && var.manage_applications }

  name               = each.value.name
  authorization_flow = local.flow_map[each.value.authorization_flow]
  invalidation_flow  = local.flow_map[each.value.invalidation_flow]
  shared_secret      = each.value.shared_secret

  mfa_support       = try(each.value.mfa_support, local.defaults.authentik.applications.providers.radius.mfa_support, true)
  client_networks   = try(each.value.client_networks, "")
  certificate       = try(each.value.certificate, "")
  property_mappings = try(each.value.property_mappings, [])
}

module "authentik_provider_scim" {
  source   = "./modules/terraform-authentik-provider-scim"
  for_each = { for p in local.providers_scim : p.name => p if local.modules.authentik_provider_scim == true && var.manage_applications }

  name = each.value.name
  url  = each.value.url

  exclude_users_service_account = try(each.value.exclude_users_service_account, local.defaults.authentik.applications.providers.scim.exclude_users_service_account, false)
  token                         = try(each.value.token, "")
  filter_group                  = try(each.value.filter_group, "")
  property_mappings             = try(each.value.property_mappings, [])
  property_mappings_group       = try(each.value.property_mappings_group, [])
}

module "authentik_provider_rac" {
  source   = "./modules/terraform-authentik-provider-rac"
  for_each = { for p in local.providers_rac : p.name => p if local.modules.authentik_provider_rac == true && var.manage_applications }

  name               = each.value.name
  authorization_flow = local.flow_map[each.value.authorization_flow]

  authentication_flow = try(local.flow_map[each.value.authentication_flow], "")
  connection_expiry   = try(each.value.connection_expiry, "")
  settings            = try(each.value.settings, "")
  property_mappings   = try(each.value.property_mappings, [])
}

module "authentik_provider_google_workspace" {
  source   = "./modules/terraform-authentik-provider-google-workspace"
  for_each = { for p in local.providers_google_workspace : p.name => p if local.modules.authentik_provider_google_workspace == true && var.manage_applications }

  name                       = each.value.name
  default_group_email_domain = each.value.default_group_email_domain

  credentials                   = try(each.value.credentials, "")
  delegated_subject             = try(each.value.delegated_subject, "")
  filter_group                  = try(each.value.filter_group, "")
  user_delete_action            = try(each.value.user_delete_action, "")
  group_delete_action           = try(each.value.group_delete_action, "")
  dry_run                       = try(each.value.dry_run, false)
  exclude_users_service_account = try(each.value.exclude_users_service_account, false)
  property_mappings             = try(each.value.property_mappings, [])
  property_mappings_group       = try(each.value.property_mappings_group, [])
}

module "authentik_provider_microsoft_entra" {
  source   = "./modules/terraform-authentik-provider-microsoft-entra"
  for_each = { for p in local.providers_microsoft_entra : p.name => p if local.modules.authentik_provider_microsoft_entra == true && var.manage_applications }

  name          = each.value.name
  client_id     = each.value.client_id
  client_secret = each.value.client_secret
  tenant_id     = each.value.tenant_id

  filter_group                  = try(each.value.filter_group, "")
  user_delete_action            = try(each.value.user_delete_action, "")
  group_delete_action           = try(each.value.group_delete_action, "")
  dry_run                       = try(each.value.dry_run, false)
  exclude_users_service_account = try(each.value.exclude_users_service_account, false)
  property_mappings             = try(each.value.property_mappings, [])
  property_mappings_group       = try(each.value.property_mappings_group, [])
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
