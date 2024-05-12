# Main definition

# Create HAH folder
resource "grafana_folder" "hah" {
  title = "Hashi@Home"
}

resource "grafana_dashboard" "nodes" {
  config_json = file("${path.module}/dashboards/nodes.json")
  folder      = grafana_folder.hah.id
}
