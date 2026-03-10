variable "name" {
  description = "Stage name."
  type        = string
}

variable "credentials" {
  description = "Credentials."
  type        = string
  sensitive   = true
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
