variable "name" {
  description = "Source name."
  type        = string
}

variable "slug" {
  description = "Source slug."
  type        = string
}

variable "client_id" {
  description = "Plex client ID."
  type        = string
}

variable "plex_token" {
  description = "Plex token."
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

variable "allow_friends" {
  description = "Allow Plex friends to authenticate."
  type        = bool
  default     = true
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

variable "allowed_servers" {
  description = "List of allowed Plex server IDs."
  type        = list(string)
  default     = []
}
