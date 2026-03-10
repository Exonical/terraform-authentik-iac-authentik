resource "authentik_flow" "this" {
  name        = var.name
  slug        = var.slug
  title       = var.title
  designation = var.designation

  authentication     = var.authentication != "" ? var.authentication : null
  background         = var.background != "" ? var.background : null
  compatibility_mode = var.compatibility_mode
  denied_action      = var.denied_action != "" ? var.denied_action : null
  layout             = var.layout != "" ? var.layout : null
  policy_engine_mode = var.policy_engine_mode != "" ? var.policy_engine_mode : null
}
