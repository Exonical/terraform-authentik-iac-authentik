locals {
  system_settings              = try(local.system.system_settings, {})
  brands                       = try(local.system.brands, [])
  certificate_key_pairs        = try(local.system.certificate_key_pairs, [])
  tokens                       = try(local.system.tokens, [])
  outposts                     = try(local.system.outposts, [])
  service_connections_docker    = try(local.system.service_connections.docker, [])
  service_connections_kubernetes = try(local.system.service_connections.kubernetes, [])
}

module "authentik_system_settings" {
  source = "./modules/terraform-authentik-system-settings"

  count = length(keys(local.system_settings)) > 0 && local.modules.authentik_system_settings == true && var.manage_system ? 1 : 0

  avatars                      = try(local.system_settings.avatars, local.defaults.authentik.system.system_settings.avatars, "gravatar,initials")
  default_user_change_name     = try(local.system_settings.default_user_change_name, local.defaults.authentik.system.system_settings.default_user_change_name, true)
  default_user_change_email    = try(local.system_settings.default_user_change_email, local.defaults.authentik.system.system_settings.default_user_change_email, false)
  default_user_change_username = try(local.system_settings.default_user_change_username, local.defaults.authentik.system.system_settings.default_user_change_username, false)
  event_retention              = try(local.system_settings.event_retention, local.defaults.authentik.system.system_settings.event_retention, "days=365")
  gdpr_compliance              = try(local.system_settings.gdpr_compliance, local.defaults.authentik.system.system_settings.gdpr_compliance, true)
  impersonation                = try(local.system_settings.impersonation, local.defaults.authentik.system.system_settings.impersonation, true)
  default_token_duration       = try(local.system_settings.default_token_duration, local.defaults.authentik.system.system_settings.default_token_duration, "minutes=30")
  default_token_length         = try(local.system_settings.default_token_length, local.defaults.authentik.system.system_settings.default_token_length, 60)
  footer_links                 = try(local.system_settings.footer_links, [])
  flags                        = try(local.system_settings.flags, "")
  reputation_lower_limit       = try(local.system_settings.reputation_lower_limit, local.defaults.authentik.system.system_settings.reputation_lower_limit, -5)
  reputation_upper_limit       = try(local.system_settings.reputation_upper_limit, local.defaults.authentik.system.system_settings.reputation_upper_limit, 5)
  pagination_default_page_size = try(local.system_settings.pagination_default_page_size, local.defaults.authentik.system.system_settings.pagination_default_page_size, 20)
  pagination_max_page_size     = try(local.system_settings.pagination_max_page_size, local.defaults.authentik.system.system_settings.pagination_max_page_size, 100)
}

module "authentik_brand" {
  source   = "./modules/terraform-authentik-brand"
  for_each = { for brand in local.brands : brand.domain => brand if local.modules.authentik_brand == true && var.manage_system }

  domain                          = each.value.domain
  default                         = try(each.value.default, local.defaults.authentik.system.brands.default)
  branding_title                  = try(each.value.branding_title, local.defaults.authentik.system.brands.branding_title)
  branding_logo                   = try(each.value.branding_logo, "")
  branding_favicon                = try(each.value.branding_favicon, "")
  branding_custom_css             = try(each.value.branding_custom_css, "")
  branding_default_flow_background = try(each.value.branding_default_flow_background, local.defaults.authentik.system.brands.branding_default_flow_background)
  flow_authentication             = try(each.value.flow_authentication, "")
  flow_invalidation               = try(each.value.flow_invalidation, "")
  flow_recovery                   = try(each.value.flow_recovery, "")
  flow_unenrollment               = try(each.value.flow_unenrollment, "")
  flow_user_settings              = try(each.value.flow_user_settings, "")
  flow_device_code                = try(each.value.flow_device_code, "")
  default_application             = try(each.value.default_application, "")
  web_certificate                 = try(each.value.web_certificate, "")
  attributes                      = try(each.value.attributes, "{}")
}

# ── Certificate Key Pairs ───────────────────────────────────────────────────

module "authentik_certificate_key_pair" {
  source   = "./modules/terraform-authentik-certificate-key-pair"
  for_each = { for c in local.certificate_key_pairs : c.name => c if local.modules.authentik_certificate_key_pair == true && var.manage_system }

  name             = each.value.name
  certificate_data = each.value.certificate_data

  key_data = try(each.value.key_data, "")
}

locals {
  certificate_key_pair_id_map = { for k, v in module.authentik_certificate_key_pair : k => v.id }
}

# ── Service Connections ─────────────────────────────────────────────────────

module "authentik_service_connection_docker" {
  source   = "./modules/terraform-authentik-service-connection-docker"
  for_each = { for sc in local.service_connections_docker : sc.name => sc if local.modules.authentik_service_connection_docker == true && var.manage_system }

  name = each.value.name

  local              = try(each.value.local, false)
  url                = try(each.value.url, "")
  tls_verification   = try(local.certificate_key_pair_id_map[each.value.tls_verification], each.value.tls_verification, "")
  tls_authentication = try(local.certificate_key_pair_id_map[each.value.tls_authentication], each.value.tls_authentication, "")
}

module "authentik_service_connection_kubernetes" {
  source   = "./modules/terraform-authentik-service-connection-kubernetes"
  for_each = { for sc in local.service_connections_kubernetes : sc.name => sc if local.modules.authentik_service_connection_kubernetes == true && var.manage_system }

  name = each.value.name

  local      = try(each.value.local, false)
  kubeconfig = try(each.value.kubeconfig, "")
  verify_ssl = try(each.value.verify_ssl, true)
}

locals {
  service_connection_id_map = merge(
    { for k, v in module.authentik_service_connection_docker : k => v.id },
    { for k, v in module.authentik_service_connection_kubernetes : k => v.id },
  )
}

# ── Tokens ──────────────────────────────────────────────────────────────────

locals {
  user_id_map = { for k, v in module.authentik_user : k => v.id }
}

module "authentik_token" {
  source   = "./modules/terraform-authentik-token"
  for_each = { for t in local.tokens : t.identifier => t if local.modules.authentik_token == true && var.manage_system }

  identifier = each.value.identifier
  user       = try(local.user_id_map[each.value.user], each.value.user)

  description  = try(each.value.description, "")
  intent       = try(each.value.intent, "")
  expiring     = try(each.value.expiring, true)
  expires      = try(each.value.expires, "")
  retrieve_key = try(each.value.retrieve_key, false)
}

# ── Outposts ────────────────────────────────────────────────────────────────

module "authentik_outpost" {
  source   = "./modules/terraform-authentik-outpost"
  for_each = { for o in local.outposts : o.name => o if local.modules.authentik_outpost == true && var.manage_system }

  name               = each.value.name
  protocol_providers = [for p in each.value.protocol_providers : try(local.provider_id_map[p], p)]

  type               = try(each.value.type, "")
  service_connection = try(local.service_connection_id_map[each.value.service_connection], each.value.service_connection, "")
  config             = try(each.value.config, "")
}