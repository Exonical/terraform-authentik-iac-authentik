resource "authentik_source_kerberos" "this" {
  name  = var.name
  slug  = var.slug
  realm = var.realm

  enabled                                = var.enabled
  sync_users                             = var.sync_users
  sync_users_password                    = var.sync_users_password
  password_login_update_internal_password = var.password_login_update_internal_password

  authentication_flow         = var.authentication_flow != "" ? var.authentication_flow : null
  enrollment_flow             = var.enrollment_flow != "" ? var.enrollment_flow : null
  policy_engine_mode          = var.policy_engine_mode != "" ? var.policy_engine_mode : null
  user_matching_mode          = var.user_matching_mode != "" ? var.user_matching_mode : null
  group_matching_mode         = var.group_matching_mode != "" ? var.group_matching_mode : null
  user_path_template          = var.user_path_template != "" ? var.user_path_template : null
  krb5_conf                   = var.krb5_conf != "" ? var.krb5_conf : null
  sync_principal              = var.sync_principal != "" ? var.sync_principal : null
  sync_password               = var.sync_password != "" ? var.sync_password : null
  sync_keytab                 = var.sync_keytab != "" ? var.sync_keytab : null
  sync_ccache                 = var.sync_ccache != "" ? var.sync_ccache : null
  spnego_server_name          = var.spnego_server_name != "" ? var.spnego_server_name : null
  spnego_keytab               = var.spnego_keytab != "" ? var.spnego_keytab : null
  spnego_ccache               = var.spnego_ccache != "" ? var.spnego_ccache : null
  sync_outgoing_trigger_mode  = var.sync_outgoing_trigger_mode != "" ? var.sync_outgoing_trigger_mode : null
}
