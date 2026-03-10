variable "app_model" {
  description = "Application model (e.g. authentik_sources_ldap.ldapsource)."
  type        = string
}

variable "model_id" {
  description = "Model ID (UUID of the resource to schedule)."
  type        = string
}

variable "crontab" {
  description = "Crontab expression."
  type        = string
}

variable "paused" {
  description = "Whether the task is paused."
  type        = bool
  default     = false
}
