locals {
  # Policies
  cust_policies_expression    = try(local.customization.policies.expression, [])
  cust_policies_password      = try(local.customization.policies.password, [])
  cust_policies_dummy         = try(local.customization.policies.dummy, [])
  cust_policies_event_matcher = try(local.customization.policies.event_matcher, [])
  cust_policies_expiry        = try(local.customization.policies.expiry, [])
  cust_policies_geoip         = try(local.customization.policies.geoip, [])
  cust_policies_reputation    = try(local.customization.policies.reputation, [])
  cust_policies_unique_password = try(local.customization.policies.unique_password, [])

  # Policy bindings
  cust_policy_bindings = try(local.customization.policy_bindings, [])

  # Property mappings - provider
  cust_pm_provider_scope              = try(local.customization.property_mappings.provider_scope, [])
  cust_pm_provider_saml               = try(local.customization.property_mappings.provider_saml, [])
  cust_pm_provider_rac                = try(local.customization.property_mappings.provider_rac, [])
  cust_pm_provider_scim               = try(local.customization.property_mappings.provider_scim, [])
  cust_pm_provider_google_workspace   = try(local.customization.property_mappings.provider_google_workspace, [])
  cust_pm_provider_microsoft_entra    = try(local.customization.property_mappings.provider_microsoft_entra, [])
  cust_pm_provider_radius             = try(local.customization.property_mappings.provider_radius, [])

  # Property mappings - source
  cust_pm_source_ldap     = try(local.customization.property_mappings.source_ldap, [])
  cust_pm_source_saml     = try(local.customization.property_mappings.source_saml, [])
  cust_pm_source_oauth    = try(local.customization.property_mappings.source_oauth, [])
  cust_pm_source_scim     = try(local.customization.property_mappings.source_scim, [])
  cust_pm_source_kerberos = try(local.customization.property_mappings.source_kerberos, [])
  cust_pm_source_plex     = try(local.customization.property_mappings.source_plex, [])

  # Property mappings - notification
  cust_pm_notification = try(local.customization.property_mappings.notification, [])
}

# ── Policies ────────────────────────────────────────────────────────────────

module "authentik_policy_expression" {
  source   = "./modules/terraform-authentik-policy-expression"
  for_each = { for p in local.cust_policies_expression : p.name => p if local.modules.authentik_policy_expression == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression

  execution_logging = try(each.value.execution_logging, false)
}

module "authentik_policy_password" {
  source   = "./modules/terraform-authentik-policy-password"
  for_each = { for p in local.cust_policies_password : p.name => p if local.modules.authentik_policy_password == true && var.manage_customization }

  name          = each.value.name
  error_message = each.value.error_message

  execution_logging        = try(each.value.execution_logging, false)
  length_min               = try(each.value.length_min, 0)
  amount_digits            = try(each.value.amount_digits, 0)
  amount_uppercase         = try(each.value.amount_uppercase, 0)
  amount_lowercase         = try(each.value.amount_lowercase, 0)
  amount_symbols           = try(each.value.amount_symbols, 0)
  symbol_charset           = try(each.value.symbol_charset, "")
  password_field           = try(each.value.password_field, "")
  check_static_rules       = try(each.value.check_static_rules, true)
  check_have_i_been_pwned  = try(each.value.check_have_i_been_pwned, false)
  check_zxcvbn             = try(each.value.check_zxcvbn, false)
  hibp_allowed_count       = try(each.value.hibp_allowed_count, 0)
  zxcvbn_score_threshold   = try(each.value.zxcvbn_score_threshold, 0)
}

module "authentik_policy_dummy" {
  source   = "./modules/terraform-authentik-policy-dummy"
  for_each = { for p in local.cust_policies_dummy : p.name => p if local.modules.authentik_policy_dummy == true && var.manage_customization }

  name = each.value.name

  execution_logging = try(each.value.execution_logging, false)
  result            = try(each.value.result, true)
  wait_min          = try(each.value.wait_min, 0)
  wait_max          = try(each.value.wait_max, 0)
}

module "authentik_policy_event_matcher" {
  source   = "./modules/terraform-authentik-policy-event-matcher"
  for_each = { for p in local.cust_policies_event_matcher : p.name => p if local.modules.authentik_policy_event_matcher == true && var.manage_customization }

  name = each.value.name

  execution_logging = try(each.value.execution_logging, false)
  action            = try(each.value.action, "")
  app               = try(each.value.app, "")
  client_ip         = try(each.value.client_ip, "")
  model             = try(each.value.model, "")
}

module "authentik_policy_expiry" {
  source   = "./modules/terraform-authentik-policy-expiry"
  for_each = { for p in local.cust_policies_expiry : p.name => p if local.modules.authentik_policy_expiry == true && var.manage_customization }

  name = each.value.name
  days = each.value.days

  execution_logging = try(each.value.execution_logging, false)
  deny_only         = try(each.value.deny_only, false)
}

module "authentik_policy_geoip" {
  source   = "./modules/terraform-authentik-policy-geoip"
  for_each = { for p in local.cust_policies_geoip : p.name => p if local.modules.authentik_policy_geoip == true && var.manage_customization }

  name = each.value.name

  execution_logging       = try(each.value.execution_logging, false)
  asns                    = try(each.value.asns, [])
  countries               = try(each.value.countries, [])
  check_history_distance  = try(each.value.check_history_distance, false)
  check_impossible_travel = try(each.value.check_impossible_travel, false)
  distance_tolerance_km   = try(each.value.distance_tolerance_km, 50)
  history_login_count     = try(each.value.history_login_count, 0)
  history_max_distance_km = try(each.value.history_max_distance_km, 0)
  impossible_tolerance_km = try(each.value.impossible_tolerance_km, 0)
}

module "authentik_policy_reputation" {
  source   = "./modules/terraform-authentik-policy-reputation"
  for_each = { for p in local.cust_policies_reputation : p.name => p if local.modules.authentik_policy_reputation == true && var.manage_customization }

  name = each.value.name

  execution_logging = try(each.value.execution_logging, false)
  check_ip          = try(each.value.check_ip, true)
  check_username    = try(each.value.check_username, true)
  threshold         = try(each.value.threshold, -5)
}

module "authentik_policy_unique_password" {
  source   = "./modules/terraform-authentik-policy-unique-password"
  for_each = { for p in local.cust_policies_unique_password : p.name => p if local.modules.authentik_policy_unique_password == true && var.manage_customization }

  name = each.value.name

  execution_logging        = try(each.value.execution_logging, false)
  num_historical_passwords = try(each.value.num_historical_passwords, 0)
  password_field           = try(each.value.password_field, "")
}

# ── Policy ID map ───────────────────────────────────────────────────────────

locals {
  policy_id_map = merge(
    { for k, v in module.authentik_policy_expression : k => v.id },
    { for k, v in module.authentik_policy_password : k => v.id },
    { for k, v in module.authentik_policy_dummy : k => v.id },
    { for k, v in module.authentik_policy_event_matcher : k => v.id },
    { for k, v in module.authentik_policy_expiry : k => v.id },
    { for k, v in module.authentik_policy_geoip : k => v.id },
    { for k, v in module.authentik_policy_reputation : k => v.id },
    { for k, v in module.authentik_policy_unique_password : k => v.id },
  )
}

# ── Policy bindings ─────────────────────────────────────────────────────────

module "authentik_policy_binding" {
  source   = "./modules/terraform-authentik-policy-binding"
  for_each = { for b in local.cust_policy_bindings : "${b.target}/${b.policy}/${b.order}" => b if local.modules.authentik_policy_binding == true && var.manage_customization }

  target = each.value.target
  order  = each.value.order

  policy         = try(local.policy_id_map[each.value.policy], each.value.policy)
  group          = try(each.value.group, "")
  user           = try(each.value.user, 0)
  enabled        = try(each.value.enabled, true)
  negate         = try(each.value.negate, false)
  timeout        = try(each.value.timeout, 30)
  failure_result = try(each.value.failure_result, false)
}

# ── Property mappings - provider ────────────────────────────────────────────

module "authentik_property_mapping_provider_scope" {
  source   = "./modules/terraform-authentik-property-mapping-provider-scope"
  for_each = { for m in local.cust_pm_provider_scope : m.name => m if local.modules.authentik_property_mapping_provider_scope == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
  scope_name = each.value.scope_name

  description = try(each.value.description, "")
}

module "authentik_property_mapping_provider_saml" {
  source   = "./modules/terraform-authentik-property-mapping-provider-saml"
  for_each = { for m in local.cust_pm_provider_saml : m.name => m if local.modules.authentik_property_mapping_provider_saml == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
  saml_name  = each.value.saml_name

  friendly_name = try(each.value.friendly_name, "")
}

module "authentik_property_mapping_provider_rac" {
  source   = "./modules/terraform-authentik-property-mapping-provider-rac"
  for_each = { for m in local.cust_pm_provider_rac : m.name => m if local.modules.authentik_property_mapping_provider_rac == true && var.manage_customization }

  name = each.value.name

  expression = try(each.value.expression, "")
  settings   = try(each.value.settings, "")
}

module "authentik_property_mapping_provider_scim" {
  source   = "./modules/terraform-authentik-property-mapping-provider-scim"
  for_each = { for m in local.cust_pm_provider_scim : m.name => m if local.modules.authentik_property_mapping_provider_scim == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_provider_google_workspace" {
  source   = "./modules/terraform-authentik-property-mapping-provider-google-workspace"
  for_each = { for m in local.cust_pm_provider_google_workspace : m.name => m if local.modules.authentik_property_mapping_provider_google_workspace == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_provider_microsoft_entra" {
  source   = "./modules/terraform-authentik-property-mapping-provider-microsoft-entra"
  for_each = { for m in local.cust_pm_provider_microsoft_entra : m.name => m if local.modules.authentik_property_mapping_provider_microsoft_entra == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_provider_radius" {
  source   = "./modules/terraform-authentik-property-mapping-provider-radius"
  for_each = { for m in local.cust_pm_provider_radius : m.name => m if local.modules.authentik_property_mapping_provider_radius == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

# ── Property mappings - source ──────────────────────────────────────────────

module "authentik_property_mapping_source_ldap" {
  source   = "./modules/terraform-authentik-property-mapping-source-ldap"
  for_each = { for m in local.cust_pm_source_ldap : m.name => m if local.modules.authentik_property_mapping_source_ldap == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_source_saml" {
  source   = "./modules/terraform-authentik-property-mapping-source-saml"
  for_each = { for m in local.cust_pm_source_saml : m.name => m if local.modules.authentik_property_mapping_source_saml == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_source_oauth" {
  source   = "./modules/terraform-authentik-property-mapping-source-oauth"
  for_each = { for m in local.cust_pm_source_oauth : m.name => m if local.modules.authentik_property_mapping_source_oauth == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_source_scim" {
  source   = "./modules/terraform-authentik-property-mapping-source-scim"
  for_each = { for m in local.cust_pm_source_scim : m.name => m if local.modules.authentik_property_mapping_source_scim == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_source_kerberos" {
  source   = "./modules/terraform-authentik-property-mapping-source-kerberos"
  for_each = { for m in local.cust_pm_source_kerberos : m.name => m if local.modules.authentik_property_mapping_source_kerberos == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

module "authentik_property_mapping_source_plex" {
  source   = "./modules/terraform-authentik-property-mapping-source-plex"
  for_each = { for m in local.cust_pm_source_plex : m.name => m if local.modules.authentik_property_mapping_source_plex == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}

# ── Property mappings - notification ────────────────────────────────────────

module "authentik_property_mapping_notification" {
  source   = "./modules/terraform-authentik-property-mapping-notification"
  for_each = { for m in local.cust_pm_notification : m.name => m if local.modules.authentik_property_mapping_notification == true && var.manage_customization }

  name       = each.value.name
  expression = each.value.expression
}
