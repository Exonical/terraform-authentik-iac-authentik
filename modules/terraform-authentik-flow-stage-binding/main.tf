resource "authentik_flow_stage_binding" "this" {
  target = var.target
  stage  = var.stage
  order  = var.order

  evaluate_on_plan        = var.evaluate_on_plan
  re_evaluate_policies    = var.re_evaluate_policies
  invalid_response_action = var.invalid_response_action != "" ? var.invalid_response_action : null
  policy_engine_mode      = var.policy_engine_mode != "" ? var.policy_engine_mode : null
}
