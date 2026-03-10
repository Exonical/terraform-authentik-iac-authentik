resource "authentik_stage_captcha" "this" {
  name            = var.name
  public_key      = var.public_key
  private_key     = var.private_key

  js_url                      = var.js_url != "" ? var.js_url : null
  api_url                     = var.api_url != "" ? var.api_url : null
  interactive                 = var.interactive
  error_on_invalid_score      = var.error_on_invalid_score
  score_min_threshold         = var.score_min_threshold
  score_max_threshold         = var.score_max_threshold
}
