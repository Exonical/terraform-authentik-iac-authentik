variable "avatars" {
  description = "Avatar configuration."
  type        = string
  default     = "gravatar,initials"
}

variable "default_user_change_name" {
  description = "Allow users to change their name."
  type        = bool
  default     = true
}

variable "default_user_change_email" {
  description = "Allow users to change their email."
  type        = bool
  default     = false
}

variable "default_user_change_username" {
  description = "Allow users to change their username."
  type        = bool
  default     = false
}

variable "event_retention" {
  description = "Event retention duration."
  type        = string
  default     = "days=365"
}

variable "gdpr_compliance" {
  description = "Enable GDPR compliance."
  type        = bool
  default     = true
}

variable "impersonation" {
  description = "Allow impersonation."
  type        = bool
  default     = true
}

variable "default_token_duration" {
  description = "Default token duration."
  type        = string
  default     = "minutes=30"
}

variable "default_token_length" {
  description = "Default token length."
  type        = number
  default     = 60
}

variable "footer_links" {
  description = "Footer links as a list of maps."
  type        = list(map(string))
  default     = []
}

variable "reputation_lower_limit" {
  description = "Reputation lower limit."
  type        = number
  default     = -5
}

variable "reputation_upper_limit" {
  description = "Reputation upper limit."
  type        = number
  default     = 5
}

variable "pagination_default_page_size" {
  description = "Default pagination page size."
  type        = number
  default     = 20
}

variable "pagination_max_page_size" {
  description = "Maximum pagination page size."
  type        = number
  default     = 100
}
