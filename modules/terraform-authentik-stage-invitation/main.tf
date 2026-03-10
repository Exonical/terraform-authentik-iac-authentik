resource "authentik_stage_invitation" "this" {
  name            = var.name

  continue_flow_without_invitation = var.continue_flow_without_invitation
}
