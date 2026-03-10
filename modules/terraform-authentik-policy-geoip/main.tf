resource "authentik_policy_geoip" "this" {
  name = var.name

  execution_logging          = var.execution_logging
  asns                       = length(var.asns) > 0 ? var.asns : null
  countries                  = length(var.countries) > 0 ? var.countries : null
  check_history_distance     = var.check_history_distance
  check_impossible_travel    = var.check_impossible_travel
  distance_tolerance_km      = var.distance_tolerance_km
  history_login_count        = var.history_login_count
  history_max_distance_km    = var.history_max_distance_km
  impossible_tolerance_km    = var.impossible_tolerance_km
}
