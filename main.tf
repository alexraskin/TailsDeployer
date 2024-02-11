resource "hcloud_server" "tailscale_node" {
  name        = "${var.server_name}-${var.location}-tailscale-node"
  image       = var.image
  server_type = var.server_type
  location    = var.location

  user_data = templatefile("${path.module}/cloudinit.tpl", {
    ssh_public_key     = var.ssh_public_key
    tailscale_auth_key = tailscale_tailnet_key.tailscale.key
    username           = var.server_username
  })
  ssh_keys = [hcloud_ssh_key.tailscale_node_key.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  labels = {
    "name"      = var.server_name
    "terraform" = "true"
    "tailscale" = "true"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ssh_keys]
  }
}

resource "hcloud_ssh_key" "tailscale_node_key" {
  name       = var.server_name
  public_key = var.ssh_public_key
}

resource "tailscale_tailnet_key" "tailscale" {
  reusable    = false
  description = "Hetnzer Cloud Server Tailnet Key for ${var.server_name}-${var.location}"
}
