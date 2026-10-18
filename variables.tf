variable "transit_mount_path" {
  type = string
}

variable "transit_key_name" {
  type = string
}

variable "approle_mount_path" {
  type = string
}

variable "approle_name" {
  type = string
}

variable "policy_name" {
  type = string
}

variable "token_ttl" {
  type    = number
  default = 900
}

variable "token_max_ttl" {
  type    = number
  default = 1800
}