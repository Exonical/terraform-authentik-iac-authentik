variable "name" {
  description = "Stage name."
  type        = string
}

variable "mode" {
  description = "Consent mode."
  type        = string
  default     = ""
}

variable "consent_expire_in" {
  description = "Consent expiry."
  type        = string
  default     = ""
}
