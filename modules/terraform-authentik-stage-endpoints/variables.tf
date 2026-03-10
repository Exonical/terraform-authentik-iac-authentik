variable "name" {
  description = "Stage name."
  type        = string
}

variable "connector" {
  description = "Connector UUID."
  type        = string
}

variable "mode" {
  description = "Mode."
  type        = string
  default     = ""
}
