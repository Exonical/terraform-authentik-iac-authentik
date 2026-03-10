variable "name" {
  description = "Property mapping name."
  type        = string
}

variable "expression" {
  description = "Property mapping expression."
  type        = string
}

variable "saml_name" {
  description = "SAML attribute name."
  type        = string
}

variable "friendly_name" {
  description = "SAML friendly name."
  type        = string
  default     = ""
}
