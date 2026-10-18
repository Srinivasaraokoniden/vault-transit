output "transit_mount_path" {
  value = vault_mount.transit.path
}

output "transit_key_name" {
  value = vault_transit_secret_backend_key.key.name
}

output "approle_mount_path" {
  value = vault_auth_backend.approle.path
}

output "approle_name" {
  value = vault_approle_auth_backend_role.app.role_name
}

output "role_id" {
  value = vault_approle_auth_backend_role.app.role_id
}

output "secret_id" {
  value     = vault_approle_auth_backend_role_secret_id.app.secret_id
  sensitive = true
}