variable "target" {
  description = "Target object UUID (flow, stage, etc)."
  type        = string
}

variable "order" {
  description = "Binding order."
  type        = number
}

variable "policy" {
  description = "Policy UUID."
  type        = string
  default     = ""
}

variable "group" {
  description = "Group UUID."
  type        = string
  default     = ""
}

variable "user" {
  description = "User ID (numeric)."
  type        = number
  default     = 0
}

variable "enabled" {
  description = "Whether the binding is enabled."
  type        = bool
  default     = true
}

variable "negate" {
  description = "Negate the policy result."
  type        = bool
  default     = false
}

variable "timeout" {
  description = "Timeout in seconds."
  type        = number
  default     = 30
}

variable "failure_result" {
  description = "Result when policy fails."
  type        = bool
  default     = false
}
