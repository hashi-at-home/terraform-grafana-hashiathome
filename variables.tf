# variables.tf
variable "stack" {
  description = "Cloud Stack configuration"
  type = object({
    region = string
    name   = string
    slug   = string
  })

  default = {
    name   = "hashiathome.grafana.net"
    region = "prod-eu-west-2"
    slug   = "hashiathome"
  }

}
