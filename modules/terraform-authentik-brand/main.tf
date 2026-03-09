resource "authentik_brand" "this" {
  domain                          = var.domain
  default                         = var.default
  branding_title                  = var.branding_title
  branding_default_flow_background = var.branding_default_flow_background

  branding_logo       = var.branding_logo != "" ? var.branding_logo : null
  branding_favicon    = var.branding_favicon != "" ? var.branding_favicon : null
  branding_custom_css = var.branding_custom_css != "" ? var.branding_custom_css : null

  flow_authentication = var.flow_authentication != "" ? var.flow_authentication : null
  flow_invalidation   = var.flow_invalidation != "" ? var.flow_invalidation : null
  flow_recovery       = var.flow_recovery != "" ? var.flow_recovery : null
  flow_unenrollment   = var.flow_unenrollment != "" ? var.flow_unenrollment : null
  flow_user_settings  = var.flow_user_settings != "" ? var.flow_user_settings : null
  flow_device_code    = var.flow_device_code != "" ? var.flow_device_code : null

  default_application = var.default_application != "" ? var.default_application : null
  web_certificate     = var.web_certificate != "" ? var.web_certificate : null
  attributes          = var.attributes != "{}" ? var.attributes : null
}
