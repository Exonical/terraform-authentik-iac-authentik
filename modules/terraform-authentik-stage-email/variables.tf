variable "name" {
  description = "Stage name."
  type        = string
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

variable "recovery_cache_timeout" {
  description = "Recovery cache timeout."
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

variable "activate_user_on_success" {
  description = "Activate user on success."
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

variable "recovery_max_attempts" {
  description = "Recovery max attempts."
  type        = number
  default     = 5
}
