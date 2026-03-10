variable "name" {
  description = "Provider name."
  type        = string
}

variable "bind_flow" {
  description = "Bind flow UUID."
  type        = string
}

variable "unbind_flow" {
  description = "Unbind flow UUID."
  type        = string
}

variable "base_dn" {
  description = "Base DN."
  type        = string
}

variable "search_mode" {
  description = "Search mode (direct or cached)."
  type        = string
  default     = "direct"
}

variable "bind_mode" {
  description = "Bind mode (direct or cached)."
  type        = string
  default     = "direct"
}

variable "mfa_support" {
  description = "Enable MFA support."
  type        = bool
  default     = true
}

variable "tls_server_name" {
  description = "TLS server name."
  type        = string
  default     = ""
}

variable "certificate" {
  description = "Certificate UUID."
  type        = string
  default     = ""
}

variable "gid_start_number" {
  description = "GID start number."
  type        = number
  default     = 0
}

variable "uid_start_number" {
  description = "UID start number."
  type        = number
  default     = 0
}
