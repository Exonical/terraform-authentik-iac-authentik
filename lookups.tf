locals {
  # UUID v4 regex; refs matching this pattern bypass name/slug lookup.
  uuid_re = "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"

  # Collect all flow references from YAML config across all sections.
  # compact() removes empty strings, distinct() deduplicates.
  all_flow_refs = distinct(compact(concat(
    # Applications - OAuth2 providers
    [for p in local.providers_oauth2 : try(p.authorization_flow, "")],
    [for p in local.providers_oauth2 : try(p.invalidation_flow, "")],
    [for p in local.providers_oauth2 : try(p.authentication_flow, "")],
    # Applications - SAML providers
    [for p in local.providers_saml : try(p.authorization_flow, "")],
    [for p in local.providers_saml : try(p.invalidation_flow, "")],
    [for p in local.providers_saml : try(p.authentication_flow, "")],
    # Applications - Proxy providers
    [for p in local.providers_proxy : try(p.authorization_flow, "")],
    [for p in local.providers_proxy : try(p.invalidation_flow, "")],
    [for p in local.providers_proxy : try(p.authentication_flow, "")],
    # Applications - LDAP providers
    [for p in local.providers_ldap : try(p.bind_flow, "")],
    [for p in local.providers_ldap : try(p.unbind_flow, "")],
    # Applications - Radius providers
    [for p in local.providers_radius : try(p.authorization_flow, "")],
    [for p in local.providers_radius : try(p.invalidation_flow, "")],
    # Applications - RAC providers
    [for p in local.providers_rac : try(p.authorization_flow, "")],
    [for p in local.providers_rac : try(p.authentication_flow, "")],
    # Directory - OAuth sources
    [for s in local.dir_sources_oauth : try(s.authentication_flow, "")],
    [for s in local.dir_sources_oauth : try(s.enrollment_flow, "")],
    # Directory - SAML sources
    [for s in local.dir_sources_saml : try(s.pre_authentication_flow, "")],
    [for s in local.dir_sources_saml : try(s.authentication_flow, "")],
    [for s in local.dir_sources_saml : try(s.enrollment_flow, "")],
    # Directory - Plex sources
    [for s in local.dir_sources_plex : try(s.authentication_flow, "")],
    [for s in local.dir_sources_plex : try(s.enrollment_flow, "")],
    # Directory - Kerberos sources
    [for s in local.dir_sources_kerberos : try(s.authentication_flow, "")],
    [for s in local.dir_sources_kerberos : try(s.enrollment_flow, "")],
    # Flows & Stages - Identification stage flow refs
    [for s in local.fs_stages_identification : try(s.enrollment_flow, "")],
    [for s in local.fs_stages_identification : try(s.recovery_flow, "")],
    [for s in local.fs_stages_identification : try(s.passwordless_flow, "")],
    # Flows & Stages - Redirect stage
    [for s in local.fs_stages_redirect : try(s.target_flow, "")],
    # Flows & Stages - Stages with configure_flow
    [for s in local.fs_stages_password : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_duo : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_email : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_sms : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_static : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_totp : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_webauthn : try(s.configure_flow, "")],
    [for s in local.fs_stages_authenticator_endpoint_gdtc : try(s.configure_flow, "")],
    # Endpoint Devices - Connector agents
    [for a in local.ed_connector_agents : try(a.authorization_flow, "")],
  )))

  # Separate UUIDs (pass-through) from slugs (need lookup)
  flow_uuid_refs = toset([for ref in local.all_flow_refs : ref if can(regex(local.uuid_re, ref))])
  flow_slug_refs = toset([for ref in local.all_flow_refs : ref if !can(regex(local.uuid_re, ref))])
}

# Look up flows by slug
data "authentik_flow" "by_slug" {
  for_each = local.flow_slug_refs
  slug     = each.value
}

locals {
  # Unified flow resolution map: ref -> UUID
  # UUIDs map to themselves, slugs map to their looked-up UUID
  flow_map = merge(
    { for ref in local.flow_uuid_refs : ref => ref },
    { for slug, flow in data.authentik_flow.by_slug : slug => flow.id },
  )
}

# ─────────────────────────────────────────────────────────────────────────────
# Certificate key pair resolution (by name → UUID)
# ─────────────────────────────────────────────────────────────────────────────

locals {
  all_cert_refs = distinct(compact(concat(
    # Applications - OAuth2
    [for p in local.providers_oauth2 : try(p.signing_key, "")],
    [for p in local.providers_oauth2 : try(p.encryption_key, "")],
    # Applications - SAML
    [for p in local.providers_saml : try(p.signing_kp, "")],
    [for p in local.providers_saml : try(p.verification_kp, "")],
    [for p in local.providers_saml : try(p.encryption_kp, "")],
    # Applications - Proxy / LDAP / Radius certificates
    [for p in local.providers_ldap : try(p.certificate, "")],
    [for p in local.providers_radius : try(p.certificate, "")],
    # Directory - SAML source certificates
    [for s in local.dir_sources_saml : try(s.signing_kp, "")],
    [for s in local.dir_sources_saml : try(s.verification_kp, "")],
    [for s in local.dir_sources_saml : try(s.encryption_kp, "")],
    # System - Brand web certificate
    [for b in local.brands : try(b.web_certificate, "")],
    # System - Docker service connection TLS refs
    [for sc in local.service_connections_docker : try(sc.tls_verification, "")],
    [for sc in local.service_connections_docker : try(sc.tls_authentication, "")],
  )))

  cert_uuid_refs = toset([for r in local.all_cert_refs : r if can(regex(local.uuid_re, r))])
  cert_name_refs = toset([
    for r in local.all_cert_refs :
    r if !can(regex(local.uuid_re, r)) && !contains([for c in local.certificate_key_pairs : c.name], r)
  ])
}

# Look up certificates by name. Excludes names already created by this module
# (those are resolved through certificate_key_pair_id_map).
data "authentik_certificate_key_pair" "by_name" {
  for_each = local.cert_name_refs
  name     = each.value
}

locals {
  # Unified certificate resolution map: ref -> UUID
  cert_map = merge(
    { for ref in local.cert_uuid_refs : ref => ref },
    { for k, v in data.authentik_certificate_key_pair.by_name : k => v.id },
    { for k, v in module.authentik_certificate_key_pair : k => v.id },
  )
}

# ─────────────────────────────────────────────────────────────────────────────
# Property mapping resolution (by name → UUID) per type
# ─────────────────────────────────────────────────────────────────────────────

locals {
  # --- OAuth2 provider scope ---
  all_pm_scope_refs = distinct(compact(flatten([
    [for p in local.providers_oauth2 : try(p.property_mappings, [])],
  ])))
  pm_scope_uuid_refs = toset([for r in local.all_pm_scope_refs : r if can(regex(local.uuid_re, r))])
  pm_scope_name_refs = toset([
    for r in local.all_pm_scope_refs :
    r if !can(regex(local.uuid_re, r)) && !contains([for m in local.cust_pm_provider_scope : m.name], r)
  ])

  # --- SAML provider mappings ---
  all_pm_saml_refs = distinct(compact(flatten([
    [for p in local.providers_saml : try(p.property_mappings, [])],
  ])))
  pm_saml_uuid_refs = toset([for r in local.all_pm_saml_refs : r if can(regex(local.uuid_re, r))])
  pm_saml_name_refs = toset([
    for r in local.all_pm_saml_refs :
    r if !can(regex(local.uuid_re, r)) && !contains([for m in local.cust_pm_provider_saml : m.name], r)
  ])

  # --- RAC provider mappings ---
  all_pm_rac_refs = distinct(compact(flatten([
    [for p in local.providers_rac : try(p.property_mappings, [])],
  ])))
  pm_rac_uuid_refs = toset([for r in local.all_pm_rac_refs : r if can(regex(local.uuid_re, r))])
  pm_rac_name_refs = toset([
    for r in local.all_pm_rac_refs :
    r if !can(regex(local.uuid_re, r)) && !contains([for m in local.cust_pm_provider_rac : m.name], r)
  ])

  # --- Radius provider mappings ---
  all_pm_radius_refs = distinct(compact(flatten([
    [for p in local.providers_radius : try(p.property_mappings, [])],
  ])))
  pm_radius_uuid_refs = toset([for r in local.all_pm_radius_refs : r if can(regex(local.uuid_re, r))])
  pm_radius_name_refs = toset([
    for r in local.all_pm_radius_refs :
    r if !can(regex(local.uuid_re, r)) && !contains([for m in local.cust_pm_provider_radius : m.name], r)
  ])

  # --- SCIM provider mappings (covers both property_mappings and property_mappings_group) ---
  all_pm_scim_refs = distinct(compact(flatten([
    [for p in local.providers_scim : try(p.property_mappings, [])],
    [for p in local.providers_scim : try(p.property_mappings_group, [])],
    [for p in local.providers_google_workspace : try(p.property_mappings, [])],
    [for p in local.providers_google_workspace : try(p.property_mappings_group, [])],
    [for p in local.providers_microsoft_entra : try(p.property_mappings, [])],
    [for p in local.providers_microsoft_entra : try(p.property_mappings_group, [])],
  ])))
  pm_scim_uuid_refs = toset([for r in local.all_pm_scim_refs : r if can(regex(local.uuid_re, r))])
  pm_scim_name_refs = toset([
    for r in local.all_pm_scim_refs :
    r if !can(regex(local.uuid_re, r)) && !contains(concat(
      [for m in local.cust_pm_provider_scim : m.name],
      [for m in local.cust_pm_provider_google_workspace : m.name],
      [for m in local.cust_pm_provider_microsoft_entra : m.name],
    ), r)
  ])

  # --- LDAP source mappings (covers both property_mappings and property_mappings_group on all sources) ---
  all_pm_source_refs = distinct(compact(flatten([
    [for s in local.dir_sources_ldap : try(s.property_mappings, [])],
    [for s in local.dir_sources_ldap : try(s.property_mappings_group, [])],
    [for s in local.dir_sources_oauth : try(s.property_mappings, [])],
    [for s in local.dir_sources_oauth : try(s.property_mappings_group, [])],
    [for s in local.dir_sources_saml : try(s.property_mappings, [])],
    [for s in local.dir_sources_saml : try(s.property_mappings_group, [])],
    [for s in local.dir_sources_scim : try(s.property_mappings, [])],
    [for s in local.dir_sources_scim : try(s.property_mappings_group, [])],
  ])))
  pm_source_uuid_refs = toset([for r in local.all_pm_source_refs : r if can(regex(local.uuid_re, r))])
  pm_source_name_refs = toset([
    for r in local.all_pm_source_refs :
    r if !can(regex(local.uuid_re, r)) && !contains(concat(
      [for m in local.cust_pm_source_ldap : m.name],
      [for m in local.cust_pm_source_oauth : m.name],
      [for m in local.cust_pm_source_saml : m.name],
      [for m in local.cust_pm_source_scim : m.name],
      [for m in local.cust_pm_source_kerberos : m.name],
      [for m in local.cust_pm_source_plex : m.name],
    ), r)
  ])

  # --- Notification mappings (used as webhook_mapping_body / webhook_mapping_headers) ---
  all_pm_notification_refs = distinct(compact(concat(
    [for t in local.ev_transports : try(t.webhook_mapping_body, "")],
    [for t in local.ev_transports : try(t.webhook_mapping_headers, "")],
  )))
  pm_notification_uuid_refs = toset([for r in local.all_pm_notification_refs : r if can(regex(local.uuid_re, r))])
  pm_notification_name_refs = toset([
    for r in local.all_pm_notification_refs :
    r if !can(regex(local.uuid_re, r)) && !contains([for m in local.cust_pm_notification : m.name], r)
  ])
}

# Property mapping lookups by name (only those types with data-source support)
data "authentik_property_mapping_provider_scope" "by_name" {
  for_each = local.pm_scope_name_refs
  name     = each.value
}

data "authentik_property_mapping_provider_saml" "by_name" {
  for_each = local.pm_saml_name_refs
  name     = each.value
}

data "authentik_property_mapping_provider_rac" "by_name" {
  for_each = local.pm_rac_name_refs
  name     = each.value
}

data "authentik_property_mapping_provider_radius" "by_name" {
  for_each = local.pm_radius_name_refs
  name     = each.value
}

data "authentik_property_mapping_provider_scim" "by_name" {
  for_each = local.pm_scim_name_refs
  name     = each.value
}

data "authentik_property_mapping_source_ldap" "by_name" {
  for_each = local.pm_source_name_refs
  name     = each.value
}

# Notification mappings have no by-name data source in the provider; users must
# either reference UUIDs directly or define them in this module (resolved via
# the local pm_notification_map).

locals {
  pm_scope_map = merge(
    { for r in local.pm_scope_uuid_refs : r => r },
    { for k, v in data.authentik_property_mapping_provider_scope.by_name : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_scope : k => v.id },
  )

  pm_saml_map = merge(
    { for r in local.pm_saml_uuid_refs : r => r },
    { for k, v in data.authentik_property_mapping_provider_saml.by_name : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_saml : k => v.id },
  )

  pm_rac_map = merge(
    { for r in local.pm_rac_uuid_refs : r => r },
    { for k, v in data.authentik_property_mapping_provider_rac.by_name : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_rac : k => v.id },
  )

  pm_radius_map = merge(
    { for r in local.pm_radius_uuid_refs : r => r },
    { for k, v in data.authentik_property_mapping_provider_radius.by_name : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_radius : k => v.id },
  )

  pm_scim_map = merge(
    { for r in local.pm_scim_uuid_refs : r => r },
    { for k, v in data.authentik_property_mapping_provider_scim.by_name : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_scim : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_google_workspace : k => v.id },
    { for k, v in module.authentik_property_mapping_provider_microsoft_entra : k => v.id },
  )

  pm_source_map = merge(
    { for r in local.pm_source_uuid_refs : r => r },
    { for k, v in data.authentik_property_mapping_source_ldap.by_name : k => v.id },
    { for k, v in module.authentik_property_mapping_source_ldap : k => v.id },
    { for k, v in module.authentik_property_mapping_source_oauth : k => v.id },
    { for k, v in module.authentik_property_mapping_source_saml : k => v.id },
    { for k, v in module.authentik_property_mapping_source_scim : k => v.id },
    { for k, v in module.authentik_property_mapping_source_kerberos : k => v.id },
    { for k, v in module.authentik_property_mapping_source_plex : k => v.id },
  )

  pm_notification_map = merge(
    { for r in local.pm_notification_uuid_refs : r => r },
    { for k, v in module.authentik_property_mapping_notification : k => v.id },
  )
}
