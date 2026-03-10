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

variable "digits" {
  description = "Number of digits."
  type        = string
  default     = ""
}
