variable "name" {
  description = "Prompt field name."
  type        = string
}

variable "field_key" {
  description = "Field key."
  type        = string
}

variable "label" {
  description = "Field label."
  type        = string
}

variable "type" {
  description = "Field type."
  type        = string
}

variable "order" {
  description = "Field order."
  type        = number
  default     = 0
}

variable "required" {
  description = "Whether field is required."
  type        = bool
  default     = false
}

variable "placeholder" {
  description = "Placeholder text."
  type        = string
  default     = ""
}

variable "placeholder_expression" {
  description = "Whether placeholder is an expression."
  type        = bool
  default     = false
}

variable "initial_value" {
  description = "Initial value."
  type        = string
  default     = ""
}

variable "initial_value_expression" {
  description = "Whether initial value is an expression."
  type        = bool
  default     = false
}

variable "sub_text" {
  description = "Sub text."
  type        = string
  default     = ""
}
