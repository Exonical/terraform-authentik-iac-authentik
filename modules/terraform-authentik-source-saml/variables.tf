variable "name" {
  description = "Source name."
  type        = string
}

variable "slug" {
  description = "Source slug."
  type        = string
}

variable "sso_url" {
  description = "SSO URL."
  type        = string
}

variable "pre_authentication_flow" {
  description = "Pre-authentication flow UUID."
  type        = string
}

variable "enabled" {
  description = "Whether source is enabled."
  type        = bool
  default     = true
}

variable "promoted" {
  description = "Show on login page."
  type        = bool
  default     = false
}

variable "authentication_flow" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "enrollment_flow" {
  description = "Enrollment flow UUID."
  type        = string
  default     = ""
}

variable "policy_engine_mode" {
  description = "Policy engine mode."
  type        = string
  default     = ""
}

variable "user_matching_mode" {
  description = "User matching mode."
  type        = string
  default     = ""
}

variable "group_matching_mode" {
  description = "Group matching mode."
  type        = string
  default     = ""
}

variable "user_path_template" {
  description = "User path template."
  type        = string
  default     = ""
}

variable "issuer" {
  description = "SAML issuer."
  type        = string
  default     = ""
}

variable "metadata" {
  description = "SAML metadata XML."
  type        = string
  default     = ""
}

variable "slo_url" {
  description = "SLO URL."
  type        = string
  default     = ""
}

variable "binding_type" {
  description = "Binding type."
  type        = string
  default     = ""
}

variable "name_id_policy" {
  description = "Name ID policy."
  type        = string
  default     = ""
}

variable "digest_algorithm" {
  description = "Digest algorithm."
  type        = string
  default     = ""
}

variable "signature_algorithm" {
  description = "Signature algorithm."
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

variable "allow_idp_initiated" {
  description = "Allow IdP-initiated SSO."
  type        = bool
  default     = false
}

variable "signed_assertion" {
  description = "Require signed assertion."
  type        = bool
  default     = false
}

variable "signed_response" {
  description = "Require signed response."
  type        = bool
  default     = false
}

variable "temporary_user_delete_after" {
  description = "Delete temporary users after duration."
  type        = string
  default     = ""
}

variable "property_mappings" {
  description = "List of property mapping UUIDs."
  type        = list(string)
  default     = []
}

variable "property_mappings_group" {
  description = "List of group property mapping UUIDs."
  type        = list(string)
  default     = []
}
