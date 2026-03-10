resource "authentik_event_rule" "this" {
  name       = var.name
  transports = var.transports

  severity                 = var.severity != "" ? var.severity : null
  destination_event_user   = var.destination_event_user
  destination_group        = var.destination_group != "" ? var.destination_group : null
}
