resource "vault_mount" "transit" {
  path        = var.transit_mount_path
  type        = "transit"
  description = "Transit encryption engine managed by Terraform"
}

resource "vault_transit_secret_backend_key" "key" {
  backend          = vault_mount.transit.path
  name             = var.transit_key_name
  type             = "aes256-gcm96"
  deletion_allowed = false
}

resource "vault_policy" "endecrypt_only" {
  name = var.policy_name

  policy = <<-EOT
    path "${var.transit_mount_path}/encrypt/${var.transit_key_name}" {
      capabilities = ["update"]
    }

    path "${var.transit_mount_path}/decrypt/${var.transit_key_name}" {
      capabilities = ["update"]
    }
  EOT
}

resource "vault_auth_backend" "approle" {
  type = "approle"
  path = var.approle_mount_path
}

resource "vault_approle_auth_backend_role" "app" {
  backend        = vault_auth_backend.approle.path
  role_name      = var.approle_name
  token_policies = [vault_policy.endecrypt_only.name]
  bind_secret_id = true
  token_ttl      = var.token_ttl
  token_max_ttl  = var.token_max_ttl
}

resource "vault_approle_auth_backend_role_secret_id" "app" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.app.role_name
}