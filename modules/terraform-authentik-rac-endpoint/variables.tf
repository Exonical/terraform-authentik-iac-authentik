variable "name" {
  description = "RAC endpoint name."
  type        = string
}

variable "host" {
  description = "RAC endpoint host."
  type        = string
}

variable "protocol" {
  description = "RAC endpoint protocol (rdp, vnc, ssh)."
  type        = string
}

variable "protocol_provider" {
  description = "RAC provider ID."
  type        = number
}

variable "maximum_connections" {
  description = "Maximum connections."
  type        = number
  default     = 1
}

variable "property_mappings" {
  description = "Property mapping UUIDs."
  type        = list(string)
  default     = []
}

variable "settings" {
  description = "RAC endpoint settings JSON."
  type        = string
  default     = ""
}
