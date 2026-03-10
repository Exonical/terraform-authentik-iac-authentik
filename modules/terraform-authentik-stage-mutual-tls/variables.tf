variable "name" {
  description = "Stage name."
  type        = string
}

variable "mode" {
  description = "Mode."
  type        = string
  default     = ""
}

variable "cert_attribute" {
  description = "Cert attribute."
  type        = string
  default     = ""
}

variable "user_attribute" {
  description = "User attribute."
  type        = string
  default     = ""
}

variable "certificate_authorities" {
  description = "Certificate authority UUIDs."
  type        = list(string)
  default     = []
}
