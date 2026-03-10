variable "name" {
  description = "Stage name."
  type        = string
}

variable "password_stage" {
  description = "Password stage UUID."
  type        = string
  default     = ""
}

variable "captcha_stage" {
  description = "Captcha stage UUID."
  type        = string
  default     = ""
}

variable "enrollment_flow" {
  description = "Enrollment flow UUID."
  type        = string
  default     = ""
}

variable "recovery_flow" {
  description = "Recovery flow UUID."
  type        = string
  default     = ""
}

variable "passwordless_flow" {
  description = "Passwordless flow UUID."
  type        = string
  default     = ""
}

variable "webauthn_stage" {
  description = "WebAuthn stage UUID."
  type        = string
  default     = ""
}

variable "case_insensitive_matching" {
  description = "Case insensitive matching."
  type        = bool
  default     = true
}

variable "show_matched_user" {
  description = "Show matched user."
  type        = bool
  default     = true
}

variable "show_source_labels" {
  description = "Show source labels."
  type        = bool
  default     = false
}

variable "pretend_user_exists" {
  description = "Pretend user exists."
  type        = bool
  default     = true
}

variable "enable_remember_me" {
  description = "Enable remember me."
  type        = bool
  default     = false
}

variable "user_fields" {
  description = "User fields."
  type        = list(string)
  default     = []
}

variable "sources" {
  description = "Source UUIDs."
  type        = list(string)
  default     = []
}
