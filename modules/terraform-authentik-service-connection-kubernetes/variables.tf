variable "name" {
  description = "Service connection name."
  type        = string
}

variable "local" {
  description = "Use local Kubernetes cluster."
  type        = bool
  default     = false
}

variable "kubeconfig" {
  description = "Kubeconfig content."
  type        = string
  default     = ""
  sensitive   = true
}

variable "verify_ssl" {
  description = "Verify SSL certificates."
  type        = bool
  default     = true
}
