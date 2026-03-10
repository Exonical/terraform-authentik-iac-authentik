variable "name" {
  description = "Stage name."
  type        = string
}

variable "source_uuid" {
  description = "Source UUID."
  type        = string
  default     = ""
}

variable "resume_timeout" {
  description = "Resume timeout."
  type        = string
  default     = ""
}
