variable "name" {
  description = "Policy name."
  type        = string
}

variable "execution_logging" {
  description = "Enable execution logging."
  type        = bool
  default     = false
}

variable "action" {
  description = "Action to match."
  type        = string
  default     = ""
}

variable "app" {
  description = "App to match."
  type        = string
  default     = ""
}

variable "client_ip" {
  description = "Client IP to match."
  type        = string
  default     = ""
}

variable "model" {
  description = "Model to match."
  type        = string
  default     = ""
}
