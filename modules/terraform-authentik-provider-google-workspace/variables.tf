variable "name" {
  description = "Provider name."
  type        = string
}

variable "default_group_email_domain" {
  description = "Default group email domain."
  type        = string
}

variable "credentials" {
  description = "Google credentials JSON."
  type        = string
  default     = ""
  sensitive   = true
}

variable "delegated_subject" {
  description = "Delegated subject email."
  type        = string
  default     = ""
}

variable "filter_group" {
  description = "Filter group UUID."
  type        = string
  default     = ""
}

variable "user_delete_action" {
  description = "User delete action."
  type        = string
  default     = ""
}

variable "group_delete_action" {
  description = "Group delete action."
  type        = string
  default     = ""
}

variable "dry_run" {
  description = "Enable dry run mode."
  type        = bool
  default     = false
}

variable "exclude_users_service_account" {
  description = "Exclude service account users."
  type        = bool
  default     = false
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
