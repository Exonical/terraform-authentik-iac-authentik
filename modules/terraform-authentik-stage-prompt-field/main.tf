resource "authentik_stage_prompt_field" "this" {
  name      = var.name
  field_key = var.field_key
  label     = var.label
  type      = var.type

  order                    = var.order
  required                 = var.required
  placeholder              = var.placeholder != "" ? var.placeholder : null
  placeholder_expression   = var.placeholder_expression
  initial_value            = var.initial_value != "" ? var.initial_value : null
  initial_value_expression = var.initial_value_expression
  sub_text                 = var.sub_text != "" ? var.sub_text : null
}
