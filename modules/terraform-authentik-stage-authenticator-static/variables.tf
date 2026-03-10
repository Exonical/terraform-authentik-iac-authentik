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

variable "token_count" {
  description = "Number of tokens."
  type        = number
  default     = 6
}

variable "token_length" {
  description = "Token length."
  type        = number
  default     = 12
}
