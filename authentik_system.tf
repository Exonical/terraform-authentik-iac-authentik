locals {
  system_settings = try(local.system.system_settings, {})
  brands          = try(local.system.brands, [])
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