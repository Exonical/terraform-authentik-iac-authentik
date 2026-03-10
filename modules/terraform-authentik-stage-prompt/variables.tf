variable "name" {
  description = "Stage name."
  type        = string
}

variable "fields" {
  description = "Prompt field UUIDs."
  type        = list(string)
}

variable "validation_policies" {
  description = "Validation policy UUIDs."
  type        = list(string)
  default     = []
}
