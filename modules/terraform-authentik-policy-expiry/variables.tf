variable "name" {
  description = "Policy name."
  type        = string
}

variable "days" {
  description = "Number of days before expiry."
  type        = number
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "deny_only" {
  description = "Only deny access, don't prompt for change."
  type        = bool
  default     = false
}
