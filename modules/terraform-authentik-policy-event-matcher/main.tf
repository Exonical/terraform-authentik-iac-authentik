resource "authentik_policy_event_matcher" "this" {
  name = var.name

  execution_logging = var.execution_logging
  action            = var.action != "" ? var.action : null
  app               = var.app != "" ? var.app : null
  client_ip         = var.client_ip != "" ? var.client_ip : null
  model             = var.model != "" ? var.model : null
}
