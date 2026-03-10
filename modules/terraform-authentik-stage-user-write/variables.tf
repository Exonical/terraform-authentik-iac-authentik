variable "name" {
  description = "Stage name."
  type        = string
}

variable "user_creation_mode" {
  description = "User creation mode."
  type        = string
  default     = ""
}

variable "user_type" {
  description = "User type."
  type        = string
  default     = ""
}

variable "user_path_template" {
  description = "User path template."
  type        = string
  default     = ""
}

variable "create_users_group" {
  description = "Create users group UUID."
  type        = string
  default     = ""
}

variable "create_users_as_inactive" {
  description = "Create users as inactive."
  type        = bool
  default     = false
}
