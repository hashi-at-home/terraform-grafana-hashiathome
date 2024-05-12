# Main definition

# Create a cloud stack
resource "grafana_cloud_stack" "hah" {
  name        = var.stack.name
  slug        = var.stack.slug
  region_slug = var.stack.region
}
