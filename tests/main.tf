module "authentik" {
  source = "../"

  yaml_files = ["${path.module}/authentik.yaml"]

  manage_system       = true
  manage_applications = true
}
