resource "authentik_blueprint" "this" {
  name = var.name

  enabled = var.enabled
  path    = var.path != "" ? var.path : null
  content = var.content != "" ? var.content : null
  context = var.context != "" ? var.context : null
}
