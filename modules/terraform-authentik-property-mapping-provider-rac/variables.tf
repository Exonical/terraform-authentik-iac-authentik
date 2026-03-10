variable "name" {
  description = "Property mapping name."
  type        = string
}

variable "expression" {
  description = "Property mapping expression."
  type        = string
  default     = ""
}

variable "settings" {
  description = "RAC settings JSON."
  type        = string
  default     = ""
}
