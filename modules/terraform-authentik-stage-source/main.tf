resource "authentik_stage_source" "this" {
  name            = var.name

  source                      = var.source_uuid != "" ? var.source_uuid : null
  resume_timeout              = var.resume_timeout != "" ? var.resume_timeout : null
}
