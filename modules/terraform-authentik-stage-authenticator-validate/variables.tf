variable "name" {
  description = "Stage name."
  type        = string
}

variable "not_configured_action" {
  description = "Not configured action."
  type        = string
}

variable "last_auth_threshold" {
  description = "Last auth threshold."
  type        = string
  default     = ""
}

variable "webauthn_user_verification" {
  description = "WebAuthn user verification."
  type        = string
  default     = ""
}

variable "configuration_stages" {
  description = "Configuration stage UUIDs."
  type        = list(string)
  default     = []
}

variable "device_classes" {
  description = "Device classes."
  type        = list(string)
  default     = []
}

variable "webauthn_allowed_device_types" {
  description = "WebAuthn allowed device types."
  type        = list(string)
  default     = []
}
