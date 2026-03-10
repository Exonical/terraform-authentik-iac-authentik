variable "name" {
  description = "Policy name."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "result" {
  description = "Policy result."
  type        = bool
  default     = true
}

variable "wait_min" {
  description = "Minimum wait time."
  type        = number
  default     = 0
}

variable "wait_max" {
  description = "Maximum wait time."
  type        = number
  default     = 0
}
