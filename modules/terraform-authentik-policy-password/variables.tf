variable "name" {
  description = "Policy name."
  type        = string
}

variable "error_message" {
  description = "Error message shown when policy fails."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "length_min" {
  description = "Minimum password length."
  type        = number
  default     = 0
}

variable "amount_digits" {
  description = "Minimum number of digits."
  type        = number
  default     = 0
}

variable "amount_uppercase" {
  description = "Minimum number of uppercase characters."
  type        = number
  default     = 0
}

variable "amount_lowercase" {
  description = "Minimum number of lowercase characters."
  type        = number
  default     = 0
}

variable "amount_symbols" {
  description = "Minimum number of symbols."
  type        = number
  default     = 0
}

variable "symbol_charset" {
  description = "Symbol charset."
  type        = string
  default     = ""
}

variable "password_field" {
  description = "Password field key."
  type        = string
  default     = ""
}

variable "check_static_rules" {
  description = "Check static rules."
  type        = bool
  default     = true
}

variable "check_have_i_been_pwned" {
  description = "Check Have I Been Pwned."
  type        = bool
  default     = false
}

variable "check_zxcvbn" {
  description = "Check zxcvbn score."
  type        = bool
  default     = false
}

variable "hibp_allowed_count" {
  description = "HIBP allowed count."
  type        = number
  default     = 0
}

variable "zxcvbn_score_threshold" {
  description = "zxcvbn score threshold."
  type        = number
  default     = 0
}
