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

variable "external_host" {
  description = "External host URL."
  type        = string
}

variable "internal_host" {
  description = "Internal host URL."
  type        = string
  default     = ""
}

variable "internal_host_ssl_validation" {
  description = "Validate internal host SSL."
  type        = bool
  default     = true
}

variable "mode" {
  description = "Proxy mode (proxy or forward_single or forward_domain)."
  type        = string
  default     = ""
}

variable "authentication_flow" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "cookie_domain" {
  description = "Cookie domain."
  type        = string
  default     = ""
}

variable "access_token_validity" {
  description = "Access token validity duration."
  type        = string
  default     = ""
}

variable "refresh_token_validity" {
  description = "Refresh token validity duration."
  type        = string
  default     = ""
}

variable "skip_path_regex" {
  description = "Regex for paths to skip authentication."
  type        = string
  default     = ""
}

variable "basic_auth_enabled" {
  description = "Enable basic auth."
  type        = bool
  default     = false
}

variable "basic_auth_username_attribute" {
  description = "Basic auth username attribute."
  type        = string
  default     = ""
}

variable "basic_auth_password_attribute" {
  description = "Basic auth password attribute."
  type        = string
  default     = ""
}

variable "intercept_header_auth" {
  description = "Intercept header authentication."
  type        = bool
  default     = true
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
