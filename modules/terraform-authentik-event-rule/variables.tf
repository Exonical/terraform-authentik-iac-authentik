variable "name" {
  description = "Event rule name."
  type        = string
}

variable "transports" {
  description = "List of transport UUIDs."
  type        = list(string)
}

variable "severity" {
  description = "Severity filter (alert, notice, warning)."
  type        = string
  default     = ""
}

variable "destination_event_user" {
  description = "Send to the user that triggered the event."
  type        = bool
  default     = false
}

variable "destination_group" {
  description = "Destination group UUID."
  type        = string
  default     = ""
}
