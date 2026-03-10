variable "name" {
  description = "Policy name."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "check_ip" {
  description = "Check IP."
  type        = bool
  default     = true
}

variable "check_username" {
  description = "Check username."
  type        = bool
  default     = true
}

variable "threshold" {
  description = "Reputation threshold."
  type        = number
  default     = -5
}
