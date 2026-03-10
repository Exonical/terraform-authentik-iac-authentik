variable "name" {
  description = "Outpost name."
  type        = string
}

variable "protocol_providers" {
  description = "List of provider IDs for the outpost."
  type        = list(number)
}

variable "type" {
  description = "Outpost type (proxy, ldap, radius, rac)."
  type        = string
  default     = ""
}

variable "service_connection" {
  description = "Service connection ID."
  type        = string
  default     = ""
}

variable "config" {
  description = "Outpost configuration JSON."
  type        = string
  default     = ""
}
