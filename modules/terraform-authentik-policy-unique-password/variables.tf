variable "name" {
  description = "Policy name."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "num_historical_passwords" {
  description = "Number of historical passwords to check."
  type        = number
  default     = 0
}

variable "password_field" {
  description = "Password field key."
  type        = string
  default     = ""
}
