resource "authentik_user" "this" {
  username = var.username
  name     = var.name

  email     = var.email != "" ? var.email : null
  is_active = var.is_active
  type      = var.type
  path      = var.path != "" ? var.path : null
  password  = var.password != "" ? var.password : null

  groups     = length(var.groups) > 0 ? var.groups : null
  attributes = var.attributes != "{}" ? var.attributes : null
}
