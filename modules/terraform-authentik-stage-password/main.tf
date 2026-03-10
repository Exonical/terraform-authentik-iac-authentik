resource "authentik_stage_password" "this" {
  name            = var.name
  backends        = var.backends

  configure_flow              = var.configure_flow != "" ? var.configure_flow : null
  allow_show_password         = var.allow_show_password
  failed_attempts_before_cancel = var.failed_attempts_before_cancel
}
