variable "name" {
  description = "Stage name."
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

variable "user_verification" {
  description = "User verification."
  type        = string
  default     = ""
}

variable "resident_key_requirement" {
  description = "Resident key requirement."
  type        = string
  default     = ""
}

variable "authenticator_attachment" {
  description = "Authenticator attachment."
  type        = string
  default     = ""
}

variable "device_type_restrictions" {
  description = "Device type restrictions."
  type        = list(string)
  default     = []
}

variable "max_attempts" {
  description = "Max attempts."
  type        = number
  default     = 5
}
