variable "name" {
  description = "Service connection name."
  type        = string
}

variable "local" {
  description = "Use local Docker socket."
  type        = bool
  default     = false
}

variable "url" {
  description = "Docker URL."
  type        = string
  default     = ""
}

variable "tls_verification" {
  description = "TLS verification certificate key pair ID."
  type        = string
  default     = ""
}

variable "tls_authentication" {
  description = "TLS authentication certificate key pair ID."
  type        = string
  default     = ""
}
