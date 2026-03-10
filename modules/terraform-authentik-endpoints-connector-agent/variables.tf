variable "name" {
  description = "Connector agent name."
  type        = string
}

variable "enabled" {
  description = "Whether the connector agent is enabled."
  type        = bool
  default     = true
}

variable "authorization_flow" {
  description = "Authorization flow UUID."
  type        = string
  default     = ""
}

variable "auth_session_duration" {
  description = "Auth session duration."
  type        = string
  default     = ""
}

variable "auth_terminate_session_on_expiry" {
  description = "Terminate session on expiry."
  type        = bool
  default     = false
}

variable "challenge_idle_timeout" {
  description = "Challenge idle timeout."
  type        = string
  default     = ""
}

variable "challenge_key" {
  description = "Challenge key."
  type        = string
  default     = ""
  sensitive   = true
}

variable "challenge_trigger_check_in" {
  description = "Challenge trigger check in."
  type        = bool
  default     = false
}

variable "refresh_interval" {
  description = "Refresh interval."
  type        = string
  default     = ""
}

variable "snapshot_expiry" {
  description = "Snapshot expiry."
  type        = string
  default     = ""
}

variable "nss_uid_offset" {
  description = "NSS UID offset."
  type        = number
  default     = 0
}

variable "nss_gid_offset" {
  description = "NSS GID offset."
  type        = number
  default     = 0
}

variable "jwt_federation_providers" {
  description = "JWT federation provider UUIDs."
  type        = list(string)
  default     = []
}
