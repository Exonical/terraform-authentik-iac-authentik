variable "name" {
  description = "Source name."
  type        = string
}

variable "slug" {
  description = "Source slug."
  type        = string
}

variable "provider_type" {
  description = "OAuth provider type."
  type        = string
}

variable "consumer_key" {
  description = "Consumer/client key."
  type        = string
}

variable "consumer_secret" {
  description = "Consumer/client secret."
  type        = string
  sensitive   = true
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

variable "authorization_code_auth_method" {
  description = "Authorization code auth method."
  type        = string
  default     = ""
}

variable "pkce" {
  description = "PKCE mode."
  type        = string
  default     = ""
}

variable "oidc_well_known_url" {
  description = "OIDC well-known URL."
  type        = string
  default     = ""
}

variable "oidc_jwks_url" {
  description = "OIDC JWKS URL."
  type        = string
  default     = ""
}

variable "oidc_jwks" {
  description = "OIDC JWKS."
  type        = string
  default     = ""
}

variable "authorization_url" {
  description = "Authorization URL."
  type        = string
  default     = ""
}

variable "access_token_url" {
  description = "Access token URL."
  type        = string
  default     = ""
}

variable "profile_url" {
  description = "Profile URL."
  type        = string
  default     = ""
}

variable "request_token_url" {
  description = "Request token URL."
  type        = string
  default     = ""
}

variable "additional_scopes" {
  description = "Additional scopes."
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
