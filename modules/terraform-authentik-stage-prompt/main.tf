resource "authentik_stage_prompt" "this" {
  name            = var.name
  fields          = var.fields

  validation_policies         = length(var.validation_policies) > 0 ? var.validation_policies : null
}
