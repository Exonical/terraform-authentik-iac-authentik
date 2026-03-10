variable "name" {
  description = "Policy name."
  type        = string
}

variable "expression" {
  description = "Policy expression."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}
