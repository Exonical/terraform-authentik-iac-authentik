terraform {
  required_version = ">= 1.8.0"

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = ">= 2025.2.0"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 1.0.2, < 2.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.3.0"
    }
  }
}