resource "authentik_stage_deny" "this" {
  name            = var.name

  deny_message                = var.deny_message != "" ? var.deny_message : null
}
