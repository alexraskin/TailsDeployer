terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.45.0"
    }
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.13.13"
    }
  }
  required_version = ">= 1.6.6"
}

provider "hcloud" {
  token = var.hetzner_token
}

provider "tailscale" {
  api_key = var.tailscale_api_key
}
