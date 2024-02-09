resource "hcloud_server" "tailscale-node" {
  name        = "${var.server_name}-${var.location}"
  image       = var.image
  server_type = var.server_type
  location    = var.location

  user_data = templatefile("${path.module}/cloudinit.tpl", {
    ssh_public_key     = var.ssh_public_key
    tailscale_auth_key = var.tailscale_auth_key
    username           = var.username
  })
  ssh_keys = [hcloud_ssh_key.tailscale.id]
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

resource "hcloud_ssh_key" "tailscale" {
  name       = var.username
  public_key = var.ssh_public_key
}
