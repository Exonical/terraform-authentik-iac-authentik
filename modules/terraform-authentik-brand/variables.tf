variable "domain" {
  description = "Domain of the brand."
  type        = string
}

variable "default" {
  description = "Whether this brand is the default."
  type        = bool
  default     = false
}

variable "branding_title" {
  description = "Branding title."
  type        = string
  default     = "authentik"
}

variable "branding_logo" {
  description = "Branding logo URL."
  type        = string
  default     = ""
}

variable "branding_favicon" {
  description = "Branding favicon URL."
  type        = string
  default     = ""
}

variable "branding_custom_css" {
  description = "Custom CSS for branding."
  type        = string
  default     = ""
}

variable "branding_default_flow_background" {
  description = "Default flow background image URL."
  type        = string
  default     = "/static/dist/assets/images/flow_background.jpg"
}

variable "flow_authentication" {
  description = "Authentication flow UUID."
  type        = string
  default     = ""
}

variable "flow_invalidation" {
  description = "Invalidation flow UUID."
  type        = string
  default     = ""
}

variable "flow_recovery" {
  description = "Recovery flow UUID."
  type        = string
  default     = ""
}

variable "flow_unenrollment" {
  description = "Unenrollment flow UUID."
  type        = string
  default     = ""
}

variable "flow_user_settings" {
  description = "User settings flow UUID."
  type        = string
  default     = ""
}

variable "flow_device_code" {
  description = "Device code flow UUID."
  type        = string
  default     = ""
}

variable "default_application" {
  description = "Default application slug."
  type        = string
  default     = ""
}

variable "web_certificate" {
  description = "Web certificate UUID."
  type        = string
  default     = ""
}

variable "attributes" {
  description = "Brand attributes as a JSON string."
  type        = string
  default     = "{}"
}
