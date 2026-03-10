variable "name" {
  description = "Application name."
  type        = string
}

variable "slug" {
  description = "Application slug."
  type        = string
}

variable "protocol_provider" {
  description = "Provider ID."
  type        = number
  default     = 0
}

variable "open_in_new_tab" {
  description = "Open in new tab."
  type        = bool
  default     = false
}

variable "meta_launch_url" {
  description = "Launch URL."
  type        = string
  default     = ""
}

variable "meta_icon" {
  description = "Icon URL."
  type        = string
  default     = ""
}

variable "meta_description" {
  description = "Application description."
  type        = string
  default     = ""
}

variable "meta_publisher" {
  description = "Publisher name."
  type        = string
  default     = ""
}

variable "group" {
  description = "Application group."
  type        = string
  default     = ""
}

variable "policy_engine_mode" {
  description = "Policy engine mode."
  type        = string
  default     = ""
}

variable "backchannel_providers" {
  description = "List of backchannel provider IDs."
  type        = list(number)
  default     = []
}
