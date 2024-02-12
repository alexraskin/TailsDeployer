#cloud-config
users:
  - name: ${username}
    groups: users, admin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${ssh_public_key}
packages:
  - ufw
package_update: true
package_upgrade: true
runcmd:
  - sudo ufw default deny incoming
  - ufw enable
  - ['sh', '-c', 'curl -fsSL https://tailscale.com/install.sh | sh']
  - ['sh', '-c', "echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf && echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf && sudo sysctl -p /etc/sysctl.d/99-tailscale.conf" ]
  - ['tailscale', 'up', '--authkey=${tailscale_auth_key}']
  - ['tailscale', 'set', '--ssh']
  - ['tailscale', 'set', '--advertise-exit-node']
