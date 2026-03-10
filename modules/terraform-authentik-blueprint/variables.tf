variable "name" {
  description = "Blueprint name."
  type        = string
}

variable "enabled" {
  description = "Whether the blueprint is enabled."
  type        = bool
  default     = true
}

variable "path" {
  description = "Blueprint path."
  type        = string
  default     = ""
}

variable "content" {
  description = "Blueprint content (inline YAML)."
  type        = string
  default     = ""
}

variable "context" {
  description = "Blueprint context JSON."
  type        = string
  default     = ""
}
