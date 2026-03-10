variable "name" {
  description = "Group name."
  type        = string
}

variable "is_superuser" {
  description = "Whether group members are superusers."
  type        = bool
  default     = false
}

variable "parents" {
  description = "List of parent group UUIDs."
  type        = list(string)
  default     = []
}

variable "users" {
  description = "List of user IDs."
  type        = list(number)
  default     = []
}

variable "roles" {
  description = "List of role UUIDs."
  type        = list(string)
  default     = []
}

variable "attributes" {
  description = "Group attributes as JSON string."
  type        = string
  default     = "{}"
}
