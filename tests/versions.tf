terraform {
  required_version = ">= 1.8.0"

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = ">= 2025.12.1"
    }
  }
}

provider "authentik" {
  url      = "http://localhost:9000"
  token    = var.authentik_token
  insecure = true
}

variable "authentik_token" {
  description = "The authentik API token. Defaults to the bootstrap token from .env."
  type        = string
  sensitive   = true
  default     = "test-token-for-terraform"
}
