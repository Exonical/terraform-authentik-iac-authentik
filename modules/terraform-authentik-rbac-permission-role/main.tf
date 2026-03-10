resource "authentik_rbac_permission_role" "this" {
  role       = var.role
  permission = var.permission

  model     = var.model != "" ? var.model : null
  object_id = var.object_id != "" ? var.object_id : null
}
