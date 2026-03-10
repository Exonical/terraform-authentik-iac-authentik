resource "authentik_stage_user_login" "this" {
  name            = var.name

  session_duration            = var.session_duration != "" ? var.session_duration : null
  remember_me_offset          = var.remember_me_offset != "" ? var.remember_me_offset : null
  remember_device             = var.remember_device != "" ? var.remember_device : null
  network_binding             = var.network_binding != "" ? var.network_binding : null
  geoip_binding               = var.geoip_binding != "" ? var.geoip_binding : null
  terminate_other_sessions    = var.terminate_other_sessions
}
