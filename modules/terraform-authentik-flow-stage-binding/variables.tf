variable "target" {
  description = "Flow UUID to bind the stage to."
  type        = string
}

variable "stage" {
  description = "Stage UUID to bind."
  type        = string
}

variable "order" {
  description = "Binding order."
  type        = number
}

variable "evaluate_on_plan" {
  description = "Evaluate on plan."
  type        = bool
  default     = false
}

variable "re_evaluate_policies" {
  description = "Re-evaluate policies."
  type        = bool
  default     = true
}

variable "invalid_response_action" {
  description = "Invalid response action."
  type        = string
  default     = ""
}

variable "policy_engine_mode" {
  description = "Policy engine mode."
  type        = string
  default     = ""
}
