variable "name" {
  description = "Stage name."
  type        = string
}

variable "public_key" {
  description = "Public key."
  type        = string
}

variable "private_key" {
  description = "Private key."
  type        = string
  sensitive   = true
}

variable "js_url" {
  description = "JS URL."
  type        = string
  default     = ""
}

variable "api_url" {
  description = "API URL."
  type        = string
  default     = ""
}

variable "interactive" {
  description = "Interactive mode."
  type        = bool
  default     = false
}

variable "error_on_invalid_score" {
  description = "Error on invalid score."
  type        = bool
  default     = true
}

variable "score_min_threshold" {
  description = "Min score threshold."
  type        = number
  default     = 0
}

variable "score_max_threshold" {
  description = "Max score threshold."
  type        = number
  default     = 0
}
