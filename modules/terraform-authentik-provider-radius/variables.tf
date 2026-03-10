variable "name" {
  description = "Provider name."
  type        = string
}

variable "authorization_flow" {
  description = "Authorization flow UUID."
  type        = string
}

variable "invalidation_flow" {
  description = "Invalidation flow UUID."
  type        = string
}

variable "shared_secret" {
  description = "Shared secret."
  type        = string
  sensitive   = true
}

variable "mfa_support" {
  description = "Enable MFA support."
  type        = bool
  default     = true
}

variable "client_networks" {
  description = "Client networks CIDR."
  type        = string
  default     = ""
}

variable "certificate" {
  description = "Certificate UUID."
  type        = string
  default     = ""
}

variable "property_mappings" {
  description = "List of property mapping UUIDs."
  type        = list(string)
  default     = []
}
