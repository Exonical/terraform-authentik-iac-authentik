locals {
  rbac_roles            = try(local.rbac.roles, [])
  rbac_permissions_role = try(local.rbac.permissions_role, [])
}

module "authentik_rbac_role" {
  source   = "./modules/terraform-authentik-rbac-role"
  for_each = { for r in local.rbac_roles : r.name => r if local.modules.authentik_rbac_role == true && var.manage_rbac }

  name = each.value.name
}

locals {
  rbac_role_map = { for k, v in module.authentik_rbac_role : k => v.id }
}

module "authentik_rbac_permission_role" {
  source   = "./modules/terraform-authentik-rbac-permission-role"
  for_each = { for p in local.rbac_permissions_role : "${p.role}/${p.permission}" => p if local.modules.authentik_rbac_permission_role == true && var.manage_rbac }

  role       = try(local.rbac_role_map[each.value.role], each.value.role)
  permission = each.value.permission

  model     = try(each.value.model, "")
  object_id = try(each.value.object_id, "")
}

