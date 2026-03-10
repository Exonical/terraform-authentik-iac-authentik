resource "authentik_group" "this" {
  name         = var.name
  is_superuser = var.is_superuser

  parents    = length(var.parents) > 0 ? var.parents : null
  users      = length(var.users) > 0 ? var.users : null
  roles      = length(var.roles) > 0 ? var.roles : null
  attributes = var.attributes != "{}" ? var.attributes : null
}
