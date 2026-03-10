variable "name" {
  description = "Certificate key pair name."
  type        = string
}

variable "certificate_data" {
  description = "PEM-encoded certificate data."
  type        = string
}

variable "key_data" {
  description = "PEM-encoded private key data."
  type        = string
  default     = ""
  sensitive   = true
}
