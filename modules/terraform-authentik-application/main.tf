resource "authentik_application" "this" {
  name = var.name
  slug = var.slug

  protocol_provider  = var.protocol_provider != 0 ? var.protocol_provider : null
  open_in_new_tab    = var.open_in_new_tab
  meta_launch_url    = var.meta_launch_url != "" ? var.meta_launch_url : null
  meta_icon          = var.meta_icon != "" ? var.meta_icon : null
  meta_description   = var.meta_description != "" ? var.meta_description : null
  meta_publisher     = var.meta_publisher != "" ? var.meta_publisher : null
  group              = var.group != "" ? var.group : null
  policy_engine_mode = var.policy_engine_mode != "" ? var.policy_engine_mode : null

  backchannel_providers = length(var.backchannel_providers) > 0 ? var.backchannel_providers : null
}
