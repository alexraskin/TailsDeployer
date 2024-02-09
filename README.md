# TailsDeployer

Deploy [Tailscale](https://tailscale.com/) onto a [Hetzner](https://www.hetzner.com/) cloud server with [Terraform](https://www.terraform.io/).

## Usage

1. Install [Terraform](https://www.terraform.io/downloads.html)

2. Clone this repository

3. Create a `terraform.tfvars` file with the following content:

```hcl
hetzner_token      = "" # https://console.hetzner.cloud/projects/<project_id>/security/api-tokens
ssh_public_key     = "" # e.g. "ssh-rsa ...."
tailscale_auth_key = "" # https://login.tailscale.com/admin/settings/keys
username           = "" # e.g. "tailscale"
```

4. Run `terraform init`

5. Run `terraform apply`

6. Log into Tailscale and authorize the new device.

7. Profit!

## Notes

- The server will be created in the `hel` datacenter by default. You can change this by setting the `location` variable in `terraform.tfvars` to `fsn1` or `hel1`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
