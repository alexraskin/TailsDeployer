terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.45.0"
    }
  }
  required_version = ">= 1.6.6"
}

provider "hcloud" {
  token = var.hetzner_token
}
