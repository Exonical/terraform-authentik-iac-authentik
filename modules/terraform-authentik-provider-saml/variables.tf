variable "name" {
  description = "Provider name."
  type        = string
}

variable "authorization_flow" {
  description = "Authorization flow UUID."
  type        = string
}

variable "invalidation_flow" {
  description = "Invalidation flow UUID."
  type        = string
}

variable "acs_url" {
  description = "ACS URL."
  type        = string
}

variable "assertion_valid_not_before" {
  description = "Assertion valid not before duration."
  type        = string
  default     = "minutes=-5"
}

variable "assertion_valid_not_on_or_after" {
  description = "Assertion valid not on or after duration."
  type        = string
  default     = "minutes=5"
}

variable "session_valid_not_on_or_after" {
  description = "Session valid not on or after duration."
  type        = string
  default     = "minutes=86400"
}

variable "digest_algorithm" {
  description = "Digest algorithm."
  type        = string
  default     = "http://www.w3.org/2001/04/xmlenc#sha256"
}

variable "signature_algorithm" {
  description = "Signature algorithm."
  type        = string
  default     = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"
}

variable "audience" {
  description = "Audience."
  type        = string
  default     = ""
}

variable "issuer" {
  description = "Issuer."
  type        = string
  default     = ""
}

variable "authentication_flow" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "sp_binding" {
  description = "SP binding."
  type        = string
  default     = ""
}

variable "signing_kp" {
  description = "Signing key pair UUID."
  type        = string
  default     = ""
}

variable "verification_kp" {
  description = "Verification key pair UUID."
  type        = string
  default     = ""
}

variable "encryption_kp" {
  description = "Encryption key pair UUID."
  type        = string
  default     = ""
}

variable "name_id_mapping" {
  description = "Name ID mapping UUID."
  type        = string
  default     = ""
}

variable "default_relay_state" {
  description = "Default relay state."
  type        = string
  default     = ""
}

variable "sls_url" {
  description = "SLS URL."
  type        = string
  default     = ""
}

variable "sls_binding" {
  description = "SLS binding."
  type        = string
  default     = ""
}

variable "logout_method" {
  description = "Logout method."
  type        = string
  default     = ""
}

variable "sign_assertion" {
  description = "Sign assertion."
  type        = bool
  default     = false
}

variable "sign_response" {
  description = "Sign response."
  type        = bool
  default     = false
}

variable "sign_logout_request" {
  description = "Sign logout request."
  type        = bool
  default     = false
}

variable "property_mappings" {
  description = "List of property mapping UUIDs."
  type        = list(string)
  default     = []
}
