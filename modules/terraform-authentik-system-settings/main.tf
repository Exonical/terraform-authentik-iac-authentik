resource "authentik_system_settings" "this" {
  avatars                      = var.avatars
  default_user_change_name     = var.default_user_change_name
  default_user_change_email    = var.default_user_change_email
  default_user_change_username = var.default_user_change_username
  event_retention              = var.event_retention
  gdpr_compliance              = var.gdpr_compliance
  impersonation                = var.impersonation
  default_token_duration       = var.default_token_duration
  default_token_length         = var.default_token_length
  reputation_lower_limit       = var.reputation_lower_limit
  reputation_upper_limit       = var.reputation_upper_limit
  pagination_default_page_size = var.pagination_default_page_size
  pagination_max_page_size     = var.pagination_max_page_size
  footer_links                 = length(var.footer_links) > 0 ? var.footer_links : null
}
