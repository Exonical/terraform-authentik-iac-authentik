variable "name" {
  description = "Stage name."
  type        = string
}

variable "client_id" {
  description = "Duo client ID."
  type        = string
}

variable "client_secret" {
  description = "Duo client secret."
  type        = string
  sensitive   = true
}

variable "api_hostname" {
  description = "Duo API hostname."
  type        = string
}

variable "configure_flow" {
  description = "Configure flow UUID."
  type        = string
  default     = ""
}

variable "friendly_name" {
  description = "Friendly name."
  type        = string
  default     = ""
}

variable "admin_integration_key" {
  description = "Admin integration key."
  type        = string
  default     = ""
}

variable "admin_secret_key" {
  description = "Admin secret key."
  type        = string
  default     = ""
  sensitive   = true
}
