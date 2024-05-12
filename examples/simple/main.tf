terraform {
  required_version = ">1.2.0"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 2"
    }
  }
}

variable "vault_mount" {
  type        = string
  description = "Name of the mount in Vault where we store API tokens"
  default     = "hashiatho.me-v2"
}

variable "grafana_secret_name" {
  type        = string
  description = "Name of the secret in the KV-v2 mount containing API tokens"
  default     = "grafana_cloud"
}

# We will use vault in this example to retrieve API tokens
provider "vault" {}

data "vault_kv_secret_v2" "grafana" {
  mount = var.vault_mount
  name  = var.grafana_secret_name
}

provider "grafana" {
  auth                      = data.vault_kv_secret_v2.grafana.data.terraform_api_key
  cloud_access_policy_token = data.vault_kv_secret_v2.grafana.data.cloud_access_policy_token
}

# Declare your backends and other terraform configuration here
# This is an example for using the consul backend.
terraform {
  backend "consul" {
    path = "terraform/grafana/env-test/simple"
  }
}


module "example" {
  source = "../../"
}
