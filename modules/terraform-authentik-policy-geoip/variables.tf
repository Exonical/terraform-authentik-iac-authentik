variable "name" {
  description = "Policy name."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "asns" {
  description = "List of ASNs."
  type        = list(number)
  default     = []
}

variable "countries" {
  description = "List of country codes."
  type        = list(string)
  default     = []
}

variable "check_history_distance" {
  description = "Check history distance."
  type        = bool
  default     = false
}

variable "check_impossible_travel" {
  description = "Check impossible travel."
  type        = bool
  default     = false
}

variable "distance_tolerance_km" {
  description = "Distance tolerance in km."
  type        = number
  default     = 50
}

variable "history_login_count" {
  description = "History login count."
  type        = number
  default     = 0
}

variable "history_max_distance_km" {
  description = "History max distance in km."
  type        = number
  default     = 0
}

variable "impossible_tolerance_km" {
  description = "Impossible tolerance in km."
  type        = number
  default     = 0
}
