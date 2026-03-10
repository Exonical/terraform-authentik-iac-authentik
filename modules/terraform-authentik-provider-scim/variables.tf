variable "name" {
  description = "Provider name."
  type        = string
}

variable "url" {
  description = "SCIM endpoint URL."
  type        = string
}

variable "exclude_users_service_account" {
  description = "Exclude service account users."
  type        = bool
  default     = false
}

variable "token" {
  description = "SCIM bearer token."
  type        = string
  default     = ""
  sensitive   = true
}

variable "filter_group" {
  description = "Filter group UUID."
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
