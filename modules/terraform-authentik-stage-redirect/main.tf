resource "authentik_stage_redirect" "this" {
  name            = var.name

  mode                        = var.mode != "" ? var.mode : null
  target_static               = var.target_static != "" ? var.target_static : null
  target_flow                 = var.target_flow != "" ? var.target_flow : null
  keep_context                = var.keep_context
}
