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
  ssh_keys     = [hcloud_ssh_key.tailscale_node_key.id]
  firewall_ids = [hcloud_firewall.tailsclae_udp_firewall.id]
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

resource "hcloud_firewall" "tailsclae_udp_firewall" {
  name = "tailscale-udp-firewall-${var.server_name}-${var.location}"
  rule {
    direction = "in"
    protocol  = "udp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
    port = "41641"
  }
}

resource "tailscale_tailnet_key" "tailscale" {
  reusable    = false
  description = "Hetnzer Cloud Server Tailnet Key for ${var.server_name}-${var.location}"
}
