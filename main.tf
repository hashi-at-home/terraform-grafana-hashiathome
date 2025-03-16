# Main definition

# Create HAH folder
resource "grafana_folder" "hah" {
  title = "Hashi@Home"
}

resource "grafana_dashboard" "nodes" {
  config_json = file("${path.module}/dashboards/nodes.json")
  folder      = grafana_folder.hah.id
}

resource "grafana_library_panel" "disk_free" {
  name       = "Node Disk Free"
  folder_uid = grafana_folder.hah.uid
  uid        = "hah-disk-node-free"
  model_json = file("${path.module}/library_panels/node-disk-free.json")
}
