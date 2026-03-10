locals {
  bp_blueprints = try(local.blueprints_cfg.blueprints, [])
}

module "authentik_blueprint" {
  source   = "./modules/terraform-authentik-blueprint"
  for_each = { for b in local.bp_blueprints : b.name => b if local.modules.authentik_blueprint == true && var.manage_blueprints }

  name = each.value.name

  enabled = try(each.value.enabled, true)
  path    = try(each.value.path, "")
  content = try(each.value.content, "")
  context = try(each.value.context, "")
}
