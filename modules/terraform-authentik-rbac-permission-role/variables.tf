variable "role" {
  description = "Role UUID."
  type        = string
}

variable "permission" {
  description = "Permission string."
  type        = string
}

variable "model" {
  description = "Model string."
  type        = string
  default     = ""
}

variable "object_id" {
  description = "Object ID."
  type        = string
  default     = ""
}
