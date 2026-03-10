locals {
  ev_transports = try(local.events.transports, [])
  ev_rules      = try(local.events.rules, [])
}

module "authentik_event_transport" {
  source   = "./modules/terraform-authentik-event-transport"
  for_each = { for t in local.ev_transports : t.name => t if local.modules.authentik_event_transport == true && var.manage_events }

  name = each.value.name
  mode = each.value.mode

  send_once               = try(each.value.send_once, false)
  webhook_url             = try(each.value.webhook_url, "")
  webhook_mapping_body    = try(each.value.webhook_mapping_body, "")
  webhook_mapping_headers = try(each.value.webhook_mapping_headers, "")
  email_subject_prefix    = try(each.value.email_subject_prefix, "")
  email_template          = try(each.value.email_template, "")
}

locals {
  ev_transport_map = { for k, v in module.authentik_event_transport : k => v.id }
}

module "authentik_event_rule" {
  source   = "./modules/terraform-authentik-event-rule"
  for_each = { for r in local.ev_rules : r.name => r if local.modules.authentik_event_rule == true && var.manage_events }

  name       = each.value.name
  transports = [for t in each.value.transports : try(local.ev_transport_map[t], t)]

  severity               = try(each.value.severity, "")
  destination_event_user = try(each.value.destination_event_user, false)
  destination_group      = try(each.value.destination_group, "")
}
