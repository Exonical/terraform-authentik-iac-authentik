variable "name" {
  description = "Property mapping name."
  type        = string
}

variable "expression" {
  description = "Property mapping expression."
  type        = string
}

variable "scope_name" {
  description = "Scope name."
  type        = string
}

variable "description" {
  description = "Scope description."
  type        = string
  default     = ""
}
