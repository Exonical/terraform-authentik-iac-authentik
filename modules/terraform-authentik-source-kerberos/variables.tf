variable "name" {
  description = "Source name."
  type        = string
}

variable "slug" {
  description = "Source slug."
  type        = string
}

variable "realm" {
  description = "Kerberos realm."
  type        = string
}

variable "enabled" {
  description = "Whether source is enabled."
  type        = bool
  default     = true
}

variable "sync_users" {
  description = "Sync users."
  type        = bool
  default     = true
}

variable "sync_users_password" {
  description = "Sync user passwords."
  type        = bool
  default     = true
}

variable "password_login_update_internal_password" {
  description = "Update internal password on login."
  type        = bool
  default     = false
}

variable "authentication_flow" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "enrollment_flow" {
  description = "Enrollment flow UUID."
  type        = string
  default     = ""
}

variable "policy_engine_mode" {
  description = "Policy engine mode."
  type        = string
  default     = ""
}

variable "user_matching_mode" {
  description = "User matching mode."
  type        = string
  default     = ""
}

variable "group_matching_mode" {
  description = "Group matching mode."
  type        = string
  default     = ""
}

variable "user_path_template" {
  description = "User path template."
  type        = string
  default     = ""
}

variable "krb5_conf" {
  description = "krb5.conf content."
  type        = string
  default     = ""
}

variable "sync_principal" {
  description = "Sync principal."
  type        = string
  default     = ""
}

variable "sync_password" {
  description = "Sync password."
  type        = string
  default     = ""
  sensitive   = true
}

variable "sync_keytab" {
  description = "Sync keytab."
  type        = string
  default     = ""
  sensitive   = true
}

variable "sync_ccache" {
  description = "Sync ccache."
  type        = string
  default     = ""
}

variable "spnego_server_name" {
  description = "SPNEGO server name."
  type        = string
  default     = ""
}

variable "spnego_keytab" {
  description = "SPNEGO keytab."
  type        = string
  default     = ""
  sensitive   = true
}

variable "spnego_ccache" {
  description = "SPNEGO ccache."
  type        = string
  default     = ""
}

variable "sync_outgoing_trigger_mode" {
  description = "Sync outgoing trigger mode."
  type        = string
  default     = ""
}
