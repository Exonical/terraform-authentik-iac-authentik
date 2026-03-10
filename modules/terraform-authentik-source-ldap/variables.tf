variable "name" {
  description = "Source name."
  type        = string
}

variable "slug" {
  description = "Source slug."
  type        = string
}

variable "server_uri" {
  description = "LDAP server URI."
  type        = string
}

variable "bind_cn" {
  description = "Bind CN."
  type        = string
}

variable "bind_password" {
  description = "Bind password."
  type        = string
  sensitive   = true
}

variable "base_dn" {
  description = "Base DN."
  type        = string
}

variable "enabled" {
  description = "Whether source is enabled."
  type        = bool
  default     = true
}

variable "start_tls" {
  description = "Enable STARTTLS."
  type        = bool
  default     = false
}

variable "sni" {
  description = "Enable SNI."
  type        = bool
  default     = false
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

variable "sync_groups" {
  description = "Sync groups."
  type        = bool
  default     = true
}

variable "delete_not_found_objects" {
  description = "Delete objects not found in LDAP."
  type        = bool
  default     = false
}

variable "lookup_groups_from_user" {
  description = "Lookup groups from user."
  type        = bool
  default     = true
}

variable "password_login_update_internal_password" {
  description = "Update internal password on login."
  type        = bool
  default     = false
}

variable "additional_user_dn" {
  description = "Additional user DN."
  type        = string
  default     = ""
}

variable "additional_group_dn" {
  description = "Additional group DN."
  type        = string
  default     = ""
}

variable "user_object_filter" {
  description = "User object filter."
  type        = string
  default     = ""
}

variable "group_object_filter" {
  description = "Group object filter."
  type        = string
  default     = ""
}

variable "group_membership_field" {
  description = "Group membership field."
  type        = string
  default     = ""
}

variable "user_membership_attribute" {
  description = "User membership attribute."
  type        = string
  default     = ""
}

variable "object_uniqueness_field" {
  description = "Object uniqueness field."
  type        = string
  default     = ""
}

variable "user_path_template" {
  description = "User path template."
  type        = string
  default     = ""
}

variable "sync_parent_group" {
  description = "Sync parent group UUID."
  type        = string
  default     = ""
}

variable "sync_outgoing_trigger_mode" {
  description = "Sync outgoing trigger mode."
  type        = string
  default     = ""
}

variable "property_mappings" {
  description = "List of property mapping UUIDs."
  type        = list(string)
  default     = []
}

variable "property_mappings_group" {
  description = "List of group property mapping UUIDs."
  type        = list(string)
  default     = []
}
