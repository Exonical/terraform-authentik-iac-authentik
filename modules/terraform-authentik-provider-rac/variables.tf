variable "name" {
  description = "Provider name."
  type        = string
}

variable "authorization_flow" {
  description = "Authorization flow UUID."
  type        = string
}

variable "authentication_flow" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "connection_expiry" {
  description = "Connection expiry duration."
  type        = string
  default     = ""
}

variable "settings" {
  description = "RAC settings as JSON string."
  type        = string
  default     = ""
}

variable "property_mappings" {
  description = "List of property mapping UUIDs."
  type        = list(string)
  default     = []
}
