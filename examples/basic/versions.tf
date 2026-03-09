terraform {
  required_version = ">= 1.8.0"

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = ">= 2025.2.0"
    }
  }
}

provider "authentik" {
  url   = "https://authentik.example.com"
  token = var.authentik_token
}

variable "authentik_token" {
  description = "The authentik API token."
  type        = string
  sensitive   = true
}
