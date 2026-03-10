module "authentik" {
  source = "../"

  yaml_files = ["${path.module}/authentik.yaml"]

  manage_system           = true
  manage_applications     = true
  manage_directory        = true
  manage_flows_and_stages = true
  manage_endpoint_devices = true
  manage_rbac             = true
  manage_tasks            = true
  manage_customization    = true
  manage_events           = true
  manage_blueprints       = true
}
