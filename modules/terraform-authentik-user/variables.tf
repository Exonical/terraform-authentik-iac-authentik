variable "username" {
  description = "Username."
  type        = string
}

variable "name" {
  description = "User display name."
  type        = string
}

variable "email" {
  description = "User email."
  type        = string
  default     = ""
}

variable "is_active" {
  description = "Whether user is active."
  type        = bool
  default     = true
}

variable "type" {
  description = "User type (internal, external, service_account)."
  type        = string
  default     = "internal"
}

variable "path" {
  description = "User path."
  type        = string
  default     = ""
}

variable "password" {
  description = "User password."
  type        = string
  default     = ""
  sensitive   = true
}

variable "groups" {
  description = "List of group UUIDs."
  type        = list(string)
  default     = []
}

variable "attributes" {
  description = "User attributes as JSON string."
  type        = string
  default     = "{}"
}
