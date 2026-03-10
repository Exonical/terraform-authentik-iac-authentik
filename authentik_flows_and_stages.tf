locals {
  fs_prompt_fields = try(local.flows_and_stages.prompt_fields, [])
  fs_flows         = try(local.flows_and_stages.flows, [])

  # Stages
  fs_stages_identification              = try(local.flows_and_stages.stages.identification, [])
  fs_stages_password                    = try(local.flows_and_stages.stages.password, [])
  fs_stages_consent                     = try(local.flows_and_stages.stages.consent, [])
  fs_stages_deny                        = try(local.flows_and_stages.stages.deny, [])
  fs_stages_dummy                       = try(local.flows_and_stages.stages.dummy, [])
  fs_stages_email                       = try(local.flows_and_stages.stages.email, [])
  fs_stages_invitation                  = try(local.flows_and_stages.stages.invitation, [])
  fs_stages_captcha                     = try(local.flows_and_stages.stages.captcha, [])
  fs_stages_prompt                      = try(local.flows_and_stages.stages.prompt, [])
  fs_stages_redirect                    = try(local.flows_and_stages.stages.redirect, [])
  fs_stages_source                      = try(local.flows_and_stages.stages.source, [])
  fs_stages_endpoints                   = try(local.flows_and_stages.stages.endpoints, [])
  fs_stages_mutual_tls                  = try(local.flows_and_stages.stages.mutual_tls, [])
  fs_stages_user_login                  = try(local.flows_and_stages.stages.user_login, [])
  fs_stages_user_logout                 = try(local.flows_and_stages.stages.user_logout, [])
  fs_stages_user_write                  = try(local.flows_and_stages.stages.user_write, [])
  fs_stages_user_delete                 = try(local.flows_and_stages.stages.user_delete, [])
  fs_stages_authenticator_duo           = try(local.flows_and_stages.stages.authenticator_duo, [])
  fs_stages_authenticator_email         = try(local.flows_and_stages.stages.authenticator_email, [])
  fs_stages_authenticator_sms           = try(local.flows_and_stages.stages.authenticator_sms, [])
  fs_stages_authenticator_static        = try(local.flows_and_stages.stages.authenticator_static, [])
  fs_stages_authenticator_totp          = try(local.flows_and_stages.stages.authenticator_totp, [])
  fs_stages_authenticator_validate      = try(local.flows_and_stages.stages.authenticator_validate, [])
  fs_stages_authenticator_webauthn      = try(local.flows_and_stages.stages.authenticator_webauthn, [])
  fs_stages_authenticator_endpoint_gdtc = try(local.flows_and_stages.stages.authenticator_endpoint_gdtc, [])

  # Flatten flow stage bindings from nested flow definitions
  fs_flow_stage_bindings = flatten([
    for flow in local.fs_flows : [
      for binding in try(flow.stage_bindings, []) : {
        flow_slug              = flow.slug
        stage                  = binding.stage
        order                  = binding.order
        evaluate_on_plan       = try(binding.evaluate_on_plan, false)
        re_evaluate_policies   = try(binding.re_evaluate_policies, true)
        invalid_response_action = try(binding.invalid_response_action, "")
        policy_engine_mode     = try(binding.policy_engine_mode, "")
      }
    ]
  ])
}

# --- Prompt Fields ---

module "authentik_stage_prompt_field" {
  source   = "./modules/terraform-authentik-stage-prompt-field"
  for_each = { for f in local.fs_prompt_fields : f.name => f if local.modules.authentik_stage_prompt_field == true && var.manage_flows_and_stages }

  name      = each.value.name
  field_key = each.value.field_key
  label     = each.value.label
  type      = each.value.type

  order                  = try(each.value.order, 0)
  required               = try(each.value.required, false)
  placeholder            = try(each.value.placeholder, "")
  placeholder_expression = try(each.value.placeholder_expression, false)
  initial_value          = try(each.value.initial_value, "")
  initial_value_expression = try(each.value.initial_value_expression, false)
  sub_text               = try(each.value.sub_text, "")
}

# --- Stages ---

module "authentik_stage_identification" {
  source   = "./modules/terraform-authentik-stage-identification"
  for_each = { for s in local.fs_stages_identification : s.name => s if local.modules.authentik_stage_identification == true && var.manage_flows_and_stages }

  name = each.value.name

  case_insensitive_matching = try(each.value.case_insensitive_matching, true)
  show_matched_user         = try(each.value.show_matched_user, true)
  show_source_labels        = try(each.value.show_source_labels, false)
  pretend_user_exists       = try(each.value.pretend_user_exists, true)
  enable_remember_me        = try(each.value.enable_remember_me, false)
  user_fields               = try(each.value.user_fields, [])
  sources                   = try(each.value.sources, [])
  password_stage            = try(module.authentik_stage_password[each.value.password_stage].id, try(each.value.password_stage, ""))
  captcha_stage             = try(module.authentik_stage_captcha[each.value.captcha_stage].id, try(each.value.captcha_stage, ""))
  webauthn_stage            = try(module.authentik_stage_authenticator_webauthn[each.value.webauthn_stage].id, try(each.value.webauthn_stage, ""))
  enrollment_flow           = try(local.flow_map[each.value.enrollment_flow], "")
  recovery_flow             = try(local.flow_map[each.value.recovery_flow], "")
  passwordless_flow         = try(local.flow_map[each.value.passwordless_flow], "")
}

module "authentik_stage_password" {
  source   = "./modules/terraform-authentik-stage-password"
  for_each = { for s in local.fs_stages_password : s.name => s if local.modules.authentik_stage_password == true && var.manage_flows_and_stages }

  name     = each.value.name
  backends = each.value.backends

  configure_flow               = try(local.flow_map[each.value.configure_flow], "")
  allow_show_password          = try(each.value.allow_show_password, true)
  failed_attempts_before_cancel = try(each.value.failed_attempts_before_cancel, 5)
}

module "authentik_stage_consent" {
  source   = "./modules/terraform-authentik-stage-consent"
  for_each = { for s in local.fs_stages_consent : s.name => s if local.modules.authentik_stage_consent == true && var.manage_flows_and_stages }

  name             = each.value.name
  mode             = try(each.value.mode, "")
  consent_expire_in = try(each.value.consent_expire_in, "")
}

module "authentik_stage_deny" {
  source   = "./modules/terraform-authentik-stage-deny"
  for_each = { for s in local.fs_stages_deny : s.name => s if local.modules.authentik_stage_deny == true && var.manage_flows_and_stages }

  name         = each.value.name
  deny_message = try(each.value.deny_message, "")
}

module "authentik_stage_dummy" {
  source   = "./modules/terraform-authentik-stage-dummy"
  for_each = { for s in local.fs_stages_dummy : s.name => s if local.modules.authentik_stage_dummy == true && var.manage_flows_and_stages }

  name = each.value.name
}

module "authentik_stage_email" {
  source   = "./modules/terraform-authentik-stage-email"
  for_each = { for s in local.fs_stages_email : s.name => s if local.modules.authentik_stage_email == true && var.manage_flows_and_stages }

  name = each.value.name

  use_global_settings      = try(each.value.use_global_settings, true)
  use_ssl                  = try(each.value.use_ssl, false)
  use_tls                  = try(each.value.use_tls, false)
  activate_user_on_success = try(each.value.activate_user_on_success, false)
  from_address             = try(each.value.from_address, "")
  host                     = try(each.value.host, "")
  port                     = try(each.value.port, 25)
  username                 = try(each.value.username, "")
  password                 = try(each.value.password, "")
  subject                  = try(each.value.subject, "")
  template                 = try(each.value.template, "")
  timeout                  = try(each.value.timeout, 10)
  token_expiry             = try(each.value.token_expiry, "")
  recovery_cache_timeout   = try(each.value.recovery_cache_timeout, "")
  recovery_max_attempts    = try(each.value.recovery_max_attempts, 5)
}

module "authentik_stage_invitation" {
  source   = "./modules/terraform-authentik-stage-invitation"
  for_each = { for s in local.fs_stages_invitation : s.name => s if local.modules.authentik_stage_invitation == true && var.manage_flows_and_stages }

  name                             = each.value.name
  continue_flow_without_invitation = try(each.value.continue_flow_without_invitation, true)
}

module "authentik_stage_captcha" {
  source   = "./modules/terraform-authentik-stage-captcha"
  for_each = { for s in local.fs_stages_captcha : s.name => s if local.modules.authentik_stage_captcha == true && var.manage_flows_and_stages }

  name        = each.value.name
  public_key  = each.value.public_key
  private_key = each.value.private_key

  interactive             = try(each.value.interactive, false)
  error_on_invalid_score  = try(each.value.error_on_invalid_score, true)
  js_url                  = try(each.value.js_url, "")
  api_url                 = try(each.value.api_url, "")
  score_min_threshold     = try(each.value.score_min_threshold, 0)
  score_max_threshold     = try(each.value.score_max_threshold, 0)
}

module "authentik_stage_prompt" {
  source   = "./modules/terraform-authentik-stage-prompt"
  for_each = { for s in local.fs_stages_prompt : s.name => s if local.modules.authentik_stage_prompt == true && var.manage_flows_and_stages }

  name              = each.value.name
  fields            = each.value.fields
  validation_policies = try(each.value.validation_policies, [])
}

module "authentik_stage_redirect" {
  source   = "./modules/terraform-authentik-stage-redirect"
  for_each = { for s in local.fs_stages_redirect : s.name => s if local.modules.authentik_stage_redirect == true && var.manage_flows_and_stages }

  name          = each.value.name
  mode          = try(each.value.mode, "")
  target_static = try(each.value.target_static, "")
  target_flow   = try(local.flow_map[each.value.target_flow], "")
  keep_context  = try(each.value.keep_context, true)
}

module "authentik_stage_source" {
  source   = "./modules/terraform-authentik-stage-source"
  for_each = { for s in local.fs_stages_source : s.name => s if local.modules.authentik_stage_source == true && var.manage_flows_and_stages }

  name           = each.value.name
  source_uuid    = try(each.value.source, "")
  resume_timeout = try(each.value.resume_timeout, "")
}

module "authentik_stage_endpoints" {
  source   = "./modules/terraform-authentik-stage-endpoints"
  for_each = { for s in local.fs_stages_endpoints : s.name => s if local.modules.authentik_stage_endpoints == true && var.manage_flows_and_stages }

  name      = each.value.name
  connector = each.value.connector
  mode      = try(each.value.mode, "")
}

module "authentik_stage_mutual_tls" {
  source   = "./modules/terraform-authentik-stage-mutual-tls"
  for_each = { for s in local.fs_stages_mutual_tls : s.name => s if local.modules.authentik_stage_mutual_tls == true && var.manage_flows_and_stages }

  name                    = each.value.name
  mode                    = try(each.value.mode, "")
  cert_attribute          = try(each.value.cert_attribute, "")
  user_attribute          = try(each.value.user_attribute, "")
  certificate_authorities = try(each.value.certificate_authorities, [])
}

module "authentik_stage_user_login" {
  source   = "./modules/terraform-authentik-stage-user-login"
  for_each = { for s in local.fs_stages_user_login : s.name => s if local.modules.authentik_stage_user_login == true && var.manage_flows_and_stages }

  name                     = each.value.name
  session_duration         = try(each.value.session_duration, "")
  remember_me_offset       = try(each.value.remember_me_offset, "")
  remember_device          = try(each.value.remember_device, "")
  network_binding          = try(each.value.network_binding, "")
  geoip_binding            = try(each.value.geoip_binding, "")
  terminate_other_sessions = try(each.value.terminate_other_sessions, false)
}

module "authentik_stage_user_logout" {
  source   = "./modules/terraform-authentik-stage-user-logout"
  for_each = { for s in local.fs_stages_user_logout : s.name => s if local.modules.authentik_stage_user_logout == true && var.manage_flows_and_stages }

  name = each.value.name
}

module "authentik_stage_user_write" {
  source   = "./modules/terraform-authentik-stage-user-write"
  for_each = { for s in local.fs_stages_user_write : s.name => s if local.modules.authentik_stage_user_write == true && var.manage_flows_and_stages }

  name                     = each.value.name
  user_creation_mode       = try(each.value.user_creation_mode, "")
  user_type                = try(each.value.user_type, "")
  user_path_template       = try(each.value.user_path_template, "")
  create_users_group       = try(each.value.create_users_group, "")
  create_users_as_inactive = try(each.value.create_users_as_inactive, false)
}

module "authentik_stage_user_delete" {
  source   = "./modules/terraform-authentik-stage-user-delete"
  for_each = { for s in local.fs_stages_user_delete : s.name => s if local.modules.authentik_stage_user_delete == true && var.manage_flows_and_stages }

  name = each.value.name
}

module "authentik_stage_authenticator_duo" {
  source   = "./modules/terraform-authentik-stage-authenticator-duo"
  for_each = { for s in local.fs_stages_authenticator_duo : s.name => s if local.modules.authentik_stage_authenticator_duo == true && var.manage_flows_and_stages }

  name          = each.value.name
  client_id     = each.value.client_id
  client_secret = each.value.client_secret
  api_hostname  = each.value.api_hostname

  configure_flow       = try(local.flow_map[each.value.configure_flow], "")
  friendly_name        = try(each.value.friendly_name, "")
  admin_integration_key = try(each.value.admin_integration_key, "")
  admin_secret_key     = try(each.value.admin_secret_key, "")
}

module "authentik_stage_authenticator_email" {
  source   = "./modules/terraform-authentik-stage-authenticator-email"
  for_each = { for s in local.fs_stages_authenticator_email : s.name => s if local.modules.authentik_stage_authenticator_email == true && var.manage_flows_and_stages }

  name = each.value.name

  configure_flow      = try(local.flow_map[each.value.configure_flow], "")
  friendly_name       = try(each.value.friendly_name, "")
  use_global_settings = try(each.value.use_global_settings, true)
  use_ssl             = try(each.value.use_ssl, false)
  use_tls             = try(each.value.use_tls, false)
  from_address        = try(each.value.from_address, "")
  host                = try(each.value.host, "")
  port                = try(each.value.port, 25)
  username            = try(each.value.username, "")
  password            = try(each.value.password, "")
  subject             = try(each.value.subject, "")
  template            = try(each.value.template, "")
  timeout             = try(each.value.timeout, 10)
  token_expiry        = try(each.value.token_expiry, "")
}

module "authentik_stage_authenticator_sms" {
  source   = "./modules/terraform-authentik-stage-authenticator-sms"
  for_each = { for s in local.fs_stages_authenticator_sms : s.name => s if local.modules.authentik_stage_authenticator_sms == true && var.manage_flows_and_stages }

  name        = each.value.name
  account_sid = each.value.account_sid
  auth        = each.value.auth
  from_number = each.value.from_number

  configure_flow = try(local.flow_map[each.value.configure_flow], "")
  friendly_name  = try(each.value.friendly_name, "")
  sms_provider   = try(each.value.sms_provider, "")
  auth_type      = try(each.value.auth_type, "")
  auth_password  = try(each.value.auth_password, "")
  mapping        = try(each.value.mapping, "")
  verify_only    = try(each.value.verify_only, false)
}

module "authentik_stage_authenticator_static" {
  source   = "./modules/terraform-authentik-stage-authenticator-static"
  for_each = { for s in local.fs_stages_authenticator_static : s.name => s if local.modules.authentik_stage_authenticator_static == true && var.manage_flows_and_stages }

  name = each.value.name

  configure_flow = try(local.flow_map[each.value.configure_flow], "")
  friendly_name  = try(each.value.friendly_name, "")
  token_count    = try(each.value.token_count, 6)
  token_length   = try(each.value.token_length, 12)
}

module "authentik_stage_authenticator_totp" {
  source   = "./modules/terraform-authentik-stage-authenticator-totp"
  for_each = { for s in local.fs_stages_authenticator_totp : s.name => s if local.modules.authentik_stage_authenticator_totp == true && var.manage_flows_and_stages }

  name = each.value.name

  configure_flow = try(local.flow_map[each.value.configure_flow], "")
  friendly_name  = try(each.value.friendly_name, "")
  digits         = try(each.value.digits, "")
}

module "authentik_stage_authenticator_validate" {
  source   = "./modules/terraform-authentik-stage-authenticator-validate"
  for_each = { for s in local.fs_stages_authenticator_validate : s.name => s if local.modules.authentik_stage_authenticator_validate == true && var.manage_flows_and_stages }

  name                  = each.value.name
  not_configured_action = each.value.not_configured_action

  last_auth_threshold         = try(each.value.last_auth_threshold, "")
  webauthn_user_verification  = try(each.value.webauthn_user_verification, "")
  configuration_stages        = try(each.value.configuration_stages, [])
  device_classes              = try(each.value.device_classes, [])
  webauthn_allowed_device_types = try(each.value.webauthn_allowed_device_types, [])
}

module "authentik_stage_authenticator_webauthn" {
  source   = "./modules/terraform-authentik-stage-authenticator-webauthn"
  for_each = { for s in local.fs_stages_authenticator_webauthn : s.name => s if local.modules.authentik_stage_authenticator_webauthn == true && var.manage_flows_and_stages }

  name = each.value.name

  configure_flow           = try(local.flow_map[each.value.configure_flow], "")
  friendly_name            = try(each.value.friendly_name, "")
  user_verification        = try(each.value.user_verification, "")
  resident_key_requirement = try(each.value.resident_key_requirement, "")
  authenticator_attachment = try(each.value.authenticator_attachment, "")
  device_type_restrictions = try(each.value.device_type_restrictions, [])
  max_attempts             = try(each.value.max_attempts, 5)
}

module "authentik_stage_authenticator_endpoint_gdtc" {
  source   = "./modules/terraform-authentik-stage-authenticator-endpoint-gdtc"
  for_each = { for s in local.fs_stages_authenticator_endpoint_gdtc : s.name => s if local.modules.authentik_stage_authenticator_endpoint_gdtc == true && var.manage_flows_and_stages }

  name        = each.value.name
  credentials = each.value.credentials

  configure_flow = try(local.flow_map[each.value.configure_flow], "")
  friendly_name  = try(each.value.friendly_name, "")
}

# --- Flows ---

module "authentik_flow" {
  source   = "./modules/terraform-authentik-flow"
  for_each = { for f in local.fs_flows : f.slug => f if local.modules.authentik_flow == true && var.manage_flows_and_stages }

  name        = each.value.name
  slug        = each.value.slug
  title       = each.value.title
  designation = each.value.designation

  authentication     = try(each.value.authentication, "")
  background         = try(each.value.background, "")
  compatibility_mode = try(each.value.compatibility_mode, false)
  denied_action      = try(each.value.denied_action, "")
  layout             = try(each.value.layout, "")
  policy_engine_mode = try(each.value.policy_engine_mode, "")
}

# --- Stage ID Map and Flow Stage Bindings ---

locals {
  stage_id_map = merge(
    { for k, v in module.authentik_stage_identification : k => v.id },
    { for k, v in module.authentik_stage_password : k => v.id },
    { for k, v in module.authentik_stage_consent : k => v.id },
    { for k, v in module.authentik_stage_deny : k => v.id },
    { for k, v in module.authentik_stage_dummy : k => v.id },
    { for k, v in module.authentik_stage_email : k => v.id },
    { for k, v in module.authentik_stage_invitation : k => v.id },
    { for k, v in module.authentik_stage_captcha : k => v.id },
    { for k, v in module.authentik_stage_prompt : k => v.id },
    { for k, v in module.authentik_stage_redirect : k => v.id },
    { for k, v in module.authentik_stage_source : k => v.id },
    { for k, v in module.authentik_stage_endpoints : k => v.id },
    { for k, v in module.authentik_stage_mutual_tls : k => v.id },
    { for k, v in module.authentik_stage_user_login : k => v.id },
    { for k, v in module.authentik_stage_user_logout : k => v.id },
    { for k, v in module.authentik_stage_user_write : k => v.id },
    { for k, v in module.authentik_stage_user_delete : k => v.id },
    { for k, v in module.authentik_stage_authenticator_duo : k => v.id },
    { for k, v in module.authentik_stage_authenticator_email : k => v.id },
    { for k, v in module.authentik_stage_authenticator_sms : k => v.id },
    { for k, v in module.authentik_stage_authenticator_static : k => v.id },
    { for k, v in module.authentik_stage_authenticator_totp : k => v.id },
    { for k, v in module.authentik_stage_authenticator_validate : k => v.id },
    { for k, v in module.authentik_stage_authenticator_webauthn : k => v.id },
    { for k, v in module.authentik_stage_authenticator_endpoint_gdtc : k => v.id },
  )
}

module "authentik_flow_stage_binding" {
  source   = "./modules/terraform-authentik-flow-stage-binding"
  for_each = { for b in local.fs_flow_stage_bindings : "${b.flow_slug}/${b.stage}/${b.order}" => b if local.modules.authentik_flow_stage_binding == true && var.manage_flows_and_stages }

  target = module.authentik_flow[each.value.flow_slug].uuid
  stage  = local.stage_id_map[each.value.stage]
  order  = each.value.order

  evaluate_on_plan        = each.value.evaluate_on_plan
  re_evaluate_policies    = each.value.re_evaluate_policies
  invalid_response_action = each.value.invalid_response_action
  policy_engine_mode      = each.value.policy_engine_mode

  depends_on = [
    module.authentik_flow,
    module.authentik_stage_identification,
    module.authentik_stage_password,
    module.authentik_stage_consent,
    module.authentik_stage_deny,
    module.authentik_stage_dummy,
    module.authentik_stage_email,
    module.authentik_stage_invitation,
    module.authentik_stage_captcha,
    module.authentik_stage_prompt,
    module.authentik_stage_redirect,
    module.authentik_stage_source,
    module.authentik_stage_endpoints,
    module.authentik_stage_mutual_tls,
    module.authentik_stage_user_login,
    module.authentik_stage_user_logout,
    module.authentik_stage_user_write,
    module.authentik_stage_user_delete,
    module.authentik_stage_authenticator_duo,
    module.authentik_stage_authenticator_email,
    module.authentik_stage_authenticator_sms,
    module.authentik_stage_authenticator_static,
    module.authentik_stage_authenticator_totp,
    module.authentik_stage_authenticator_validate,
    module.authentik_stage_authenticator_webauthn,
    module.authentik_stage_authenticator_endpoint_gdtc,
  ]
}
