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

variable "client_id" {
  description = "OAuth2 client ID."
  type        = string
}

variable "client_type" {
  description = "Client type (confidential or public)."
  type        = string
  default     = "confidential"
}

variable "client_secret" {
  description = "OAuth2 client secret."
  type        = string
  default     = ""
  sensitive   = true
}

variable "include_claims_in_id_token" {
  description = "Include claims in ID token."
  type        = bool
  default     = true
}

variable "issuer_mode" {
  description = "Issuer mode."
  type        = string
  default     = "per_provider"
}

variable "sub_mode" {
  description = "Subject mode."
  type        = string
  default     = "hashed_user_id"
}

variable "access_code_validity" {
  description = "Access code validity duration."
  type        = string
  default     = "minutes=1"
}

variable "access_token_validity" {
  description = "Access token validity duration."
  type        = string
  default     = "minutes=5"
}

variable "refresh_token_validity" {
  description = "Refresh token validity duration."
  type        = string
  default     = "days=30"
}

variable "authentication_flow" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "signing_key" {
  description = "Signing key UUID."
  type        = string
  default     = ""
}

variable "encryption_key" {
  description = "Encryption key UUID."
  type        = string
  default     = ""
}

variable "logout_method" {
  description = "Logout method."
  type        = string
  default     = ""
}

variable "logout_uri" {
  description = "Logout URI."
  type        = string
  default     = ""
}

variable "allowed_redirect_uris" {
  description = "List of allowed redirect URIs."
  type        = list(map(string))
  default     = []
}

variable "property_mappings" {
  description = "List of property mapping UUIDs."
  type        = list(string)
  default     = []
}

variable "jwks_sources" {
  description = "List of JWKS source UUIDs."
  type        = list(string)
  default     = []
}
