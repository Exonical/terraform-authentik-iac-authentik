variable "name" {
  description = "Source name."
  type        = string
}

variable "slug" {
  description = "Source slug."
  type        = string
}

variable "enabled" {
  description = "Whether source is enabled."
  type        = bool
  default     = true
}

variable "user_path_template" {
  description = "User path template."
  type        = string
  default     = ""
}

variable "token" {
  description = "SCIM token."
  type        = string
  default     = ""
  sensitive   = true
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
