variable "name" {
  description = "Stage name."
  type        = string
}

variable "account_sid" {
  description = "Account SID."
  type        = string
}

variable "auth" {
  description = "Auth token."
  type        = string
  sensitive   = true
}

variable "from_number" {
  description = "From number."
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

variable "sms_provider" {
  description = "SMS provider."
  type        = string
  default     = ""
}

variable "auth_type" {
  description = "Auth type."
  type        = string
  default     = ""
}

variable "auth_password" {
  description = "Auth password."
  type        = string
  default     = ""
  sensitive   = true
}

variable "mapping" {
  description = "Mapping UUID."
  type        = string
  default     = ""
}

variable "verify_only" {
  description = "Verify only."
  type        = bool
  default     = false
}
