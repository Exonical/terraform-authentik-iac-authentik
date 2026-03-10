locals {
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
  flow_uuid_refs = toset([for ref in local.all_flow_refs : ref if can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", ref))])
  flow_slug_refs = toset([for ref in local.all_flow_refs : ref if !can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", ref))])
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
