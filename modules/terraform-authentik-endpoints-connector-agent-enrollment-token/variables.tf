variable "name" {
  description = "Enrollment token name."
  type        = string
}

variable "connector" {
  description = "Connector agent UUID."
  type        = string
}

variable "device_access_group" {
  description = "Device access group UUID."
  type        = string
  default     = ""
}

variable "expiring" {
  description = "Whether the token expires."
  type        = bool
  default     = true
}

variable "expires" {
  description = "Token expiry datetime."
  type        = string
  default     = ""
}

variable "retrieve_key" {
  description = "Whether to retrieve the key."
  type        = bool
  default     = true
}
