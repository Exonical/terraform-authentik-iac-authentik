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

variable "from_address" {
  description = "From address."
  type        = string
  default     = ""
}

variable "host" {
  description = "SMTP host."
  type        = string
  default     = ""
}

variable "username" {
  description = "SMTP username."
  type        = string
  default     = ""
}

variable "password" {
  description = "SMTP password."
  type        = string
  default     = ""
  sensitive   = true
}

variable "subject" {
  description = "Email subject."
  type        = string
  default     = ""
}

variable "template" {
  description = "Email template."
  type        = string
  default     = ""
}

variable "token_expiry" {
  description = "Token expiry."
  type        = string
  default     = ""
}

variable "use_global_settings" {
  description = "Use global settings."
  type        = bool
  default     = true
}

variable "use_ssl" {
  description = "Use SSL."
  type        = bool
  default     = false
}

variable "use_tls" {
  description = "Use TLS."
  type        = bool
  default     = false
}

variable "port" {
  description = "SMTP port."
  type        = number
  default     = 25
}

variable "timeout" {
  description = "Timeout."
  type        = number
  default     = 10
}
