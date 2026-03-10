resource "authentik_stage_endpoints" "this" {
  name            = var.name
  connector       = var.connector

  mode                        = var.mode != "" ? var.mode : null
}
