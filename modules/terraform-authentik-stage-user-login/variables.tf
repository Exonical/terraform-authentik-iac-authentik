variable "name" {
  description = "Stage name."
  type        = string
}

variable "session_duration" {
  description = "Session duration."
  type        = string
  default     = ""
}

variable "remember_me_offset" {
  description = "Remember me offset."
  type        = string
  default     = ""
}

variable "remember_device" {
  description = "Remember device."
  type        = string
  default     = ""
}

variable "network_binding" {
  description = "Network binding."
  type        = string
  default     = ""
}

variable "geoip_binding" {
  description = "GeoIP binding."
  type        = string
  default     = ""
}

variable "terminate_other_sessions" {
  description = "Terminate other sessions."
  type        = bool
  default     = false
}
