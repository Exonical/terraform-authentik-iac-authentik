resource "authentik_certificate_key_pair" "this" {
  count = var.key_data != "" ? 1 : 0

  name             = var.name
  certificate_data = var.certificate_data
  key_data         = var.key_data
}

resource "authentik_certificate_key_pair" "cert_only" {
  count = var.key_data == "" ? 1 : 0

  name             = var.name
  certificate_data = var.certificate_data

  lifecycle {
    ignore_changes = [key_data]
  }
}
