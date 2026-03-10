variable "name" {
  description = "Transport name."
  type        = string
}

variable "mode" {
  description = "Transport mode (local_email, webhook, webhook_slack, etc)."
  type        = string
}

variable "send_once" {
  description = "Only send notification once per event."
  type        = bool
  default     = false
}

variable "webhook_url" {
  description = "Webhook URL."
  type        = string
  default     = ""
}

variable "webhook_mapping_body" {
  description = "Webhook body mapping UUID."
  type        = string
  default     = ""
}

variable "webhook_mapping_headers" {
  description = "Webhook headers mapping UUID."
  type        = string
  default     = ""
}

variable "email_subject_prefix" {
  description = "Email subject prefix."
  type        = string
  default     = ""
}

variable "email_template" {
  description = "Email template."
  type        = string
  default     = ""
}
