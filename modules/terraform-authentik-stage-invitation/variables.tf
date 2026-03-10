variable "name" {
  description = "Stage name."
  type        = string
}

variable "continue_flow_without_invitation" {
  description = "Continue flow without invitation."
  type        = bool
  default     = true
}
