variable "name" {
  description = "Flow name."
  type        = string
}

variable "slug" {
  description = "Flow slug."
  type        = string
}

variable "title" {
  description = "Flow title."
  type        = string
}

variable "designation" {
  description = "Flow designation (authorization, authentication, enrollment, invalidation, recovery, stage_configuration, unenrollment)."
  type        = string
}

variable "authentication" {
  description = "Authentication requirement."
  type        = string
  default     = ""
}

variable "background" {
  description = "Background image URL."
  type        = string
  default     = ""
}

variable "compatibility_mode" {
  description = "Enable compatibility mode."
  type        = bool
  default     = false
}

variable "denied_action" {
  description = "Denied action."
  type        = string
  default     = ""
}

variable "layout" {
  description = "Flow layout."
  type        = string
  default     = ""
}

variable "policy_engine_mode" {
  description = "Policy engine mode."
  type        = string
  default     = ""
}
