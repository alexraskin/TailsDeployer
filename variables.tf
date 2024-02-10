variable "hetzner_token" {
  description = "The Hetzner Cloud API token"
  type        = string
}

variable "tailscale_api_key" {
  description = "The Tailscale API key"
  type        = string

}

variable "ssh_public_key" {
  description = "The SSH public key to use for the server"
  type        = string
}

variable "server_username" {
  description = "The username to create on the server"
  type        = string
}

variable "server_type" {
  description = "The server type to use"
  type        = string
  default     = "cpx11"
}

variable "location" {
  description = "The location to create the server in"
  type        = string
  default     = "hil"
}

variable "image" {
  description = "The image to use for the server"
  type        = string
  default     = "ubuntu-22.04"
}

variable "server_name" {
  description = "The name of the server"
  type        = string
  default     = "tailscale-node"
}
