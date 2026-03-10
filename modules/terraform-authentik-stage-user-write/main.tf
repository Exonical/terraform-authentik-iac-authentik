resource "authentik_stage_user_write" "this" {
  name            = var.name

  user_creation_mode          = var.user_creation_mode != "" ? var.user_creation_mode : null
  user_type                   = var.user_type != "" ? var.user_type : null
  user_path_template          = var.user_path_template != "" ? var.user_path_template : null
  create_users_group          = var.create_users_group != "" ? var.create_users_group : null
  create_users_as_inactive    = var.create_users_as_inactive
}
