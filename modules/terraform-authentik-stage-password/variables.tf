variable "name" {
  description = "Stage name."
  type        = string
}

variable "backends" {
  description = "Authentication backends."
  type        = list(string)
}

variable "configure_flow" {
  description = "Configure flow UUID."
  type        = string
  default     = ""
}

variable "allow_show_password" {
  description = "Allow show password."
  type        = bool
  default     = true
}

variable "failed_attempts_before_cancel" {
  description = "Failed attempts before cancel."
  type        = number
  default     = 5
}
