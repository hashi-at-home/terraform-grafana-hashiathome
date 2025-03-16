terraform {
  required_version = ">1.2.0"
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 3"
    }
  }
  backend "consul" {
    path = "terraform/grafana/env-test/simple"
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

# Create the cloud provider to interact with stacks
provider "grafana" {
  alias                     = "cloud"
  cloud_access_policy_token = data.vault_kv_secret_v2.grafana.data.cloud_access_policy_token
}

data "grafana_cloud_stack" "hah" {
  provider = grafana.cloud
  slug     = "hashiathome"
}

resource "grafana_cloud_stack_service_account" "cloud_sa" {
  provider    = grafana.cloud
  name        = "terraform"
  role        = "Admin"
  stack_slug  = data.grafana_cloud_stack.hah.slug
  is_disabled = false
}

resource "grafana_cloud_stack_service_account_token" "cloud_sa" {
  provider           = grafana.cloud
  stack_slug         = "hashiathome"
  name               = "Terraform SA Key"
  service_account_id = grafana_cloud_stack_service_account.cloud_sa.id
}

# Create the stack provider to interact with the stack selected.
provider "grafana" {
  alias = "stack"
  url   = "https://hashiathome.grafana.net"
  auth  = grafana_cloud_stack_service_account_token.cloud_sa.key
}

module "example" {
  # Use the stack provider to create grafana app objects
  providers = {
    grafana = grafana.stack
  }
  source = "../../"
}
