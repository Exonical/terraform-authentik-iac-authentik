resource "authentik_event_transport" "this" {
  name = var.name
  mode = var.mode

  send_once               = var.send_once
  webhook_url             = var.webhook_url != "" ? var.webhook_url : null
  webhook_mapping_body    = var.webhook_mapping_body != "" ? var.webhook_mapping_body : null
  webhook_mapping_headers = var.webhook_mapping_headers != "" ? var.webhook_mapping_headers : null
  email_subject_prefix    = var.email_subject_prefix != "" ? var.email_subject_prefix : null
  email_template          = var.email_template != "" ? var.email_template : null
}
