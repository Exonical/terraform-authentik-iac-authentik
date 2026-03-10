variable "name" {
  description = "Stage name."
  type        = string
}

variable "mode" {
  description = "Redirect mode."
  type        = string
  default     = ""
}

variable "target_static" {
  description = "Static target URL."
  type        = string
  default     = ""
}

variable "target_flow" {
  description = "Target flow UUID."
  type        = string
  default     = ""
}

variable "keep_context" {
  description = "Keep context."
  type        = bool
  default     = true
}
