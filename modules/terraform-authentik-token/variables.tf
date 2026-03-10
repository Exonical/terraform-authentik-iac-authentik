variable "identifier" {
  description = "Token identifier."
  type        = string
}

variable "user" {
  description = "User ID the token belongs to."
  type        = number
}

variable "description" {
  description = "Token description."
  type        = string
  default     = ""
}

variable "intent" {
  description = "Token intent (api, verification, recovery)."
  type        = string
  default     = ""
}

variable "expiring" {
  description = "Whether the token expires."
  type        = bool
  default     = true
}

variable "expires" {
  description = "Token expiration date/time."
  type        = string
  default     = ""
}

variable "retrieve_key" {
  description = "Whether to retrieve the token key."
  type        = bool
  default     = false
}
