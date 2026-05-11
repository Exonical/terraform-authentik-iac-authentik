# Terraform Authentik Infrastructure-as-Code Module

A Terraform module to configure [authentik](https://goauthentik.io) using an infrastructure-as-code approach. Inspired by the [NetAsCode terraform-aci-nac-aci](https://github.com/netascode/terraform-aci-nac-aci) pattern, this module allows users to define their entire authentik configuration in YAML files and manage it declaratively with Terraform.

## Usage

This module supports an inventory-driven approach, where a complete authentik configuration or parts of it are either modeled in one or more YAML files or natively using Terraform variables.

There are ten configuration sections which can be selectively enabled or disabled using module flags:

- **system**: Brands, system settings, certificates, outposts, service connections
- **applications**: Applications and providers (OAuth2, SAML, Proxy, LDAP, etc.)
- **directory**: Users, groups, and sources (LDAP, OAuth, SAML, etc.)
- **flows_and_stages**: Flows, stages, and flow-stage bindings
- **customization**: Policies, property mappings, and policy bindings
- **events**: Event rules and transports
- **rbac**: Roles and permissions
- **blueprints**: Blueprint instances
- **endpoint_devices**: Connector agents, device access groups
- **tasks**: Task schedules

## Examples

### Configuring a Brand using YAML

#### authentik.yaml

```yaml
authentik:
  system:
    brands:
      - domain: "."
        default: true
        branding_title: "My Company"
```

#### main.tf

```hcl
module "authentik" {
  source  = "path/to/terraform-authentik-iac-authentik"

  yaml_files    = ["authentik.yaml"]
  manage_system = true
}
```

### Configuring using native HCL

```hcl
module "authentik" {
  source  = "path/to/terraform-authentik-iac-authentik"

  model = {
    authentik = {
      system = {
        brands = [
          {
            domain         = "."
            default        = true
            branding_title = "My Company"
          }
        ]
      }
    }
  }

  manage_system = true
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| authentik | >= 2025.2.0 |
| local | >= 2.3.0 |
| utils | >= 1.0.2, < 2.0.0 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| yaml_directories | List of paths to YAML directories. | `list(string)` | `[]` |
| yaml_files | List of paths to YAML files. | `list(string)` | `[]` |
| model | Native Terraform data structure (alternative to YAML). | `any` | `{}` |
| manage_system | Flag to manage system settings. | `bool` | `false` |
| manage_applications | Flag to manage applications. | `bool` | `false` |
| manage_directory | Flag to manage directory. | `bool` | `false` |
| manage_flows_and_stages | Flag to manage flows and stages. | `bool` | `false` |
| manage_customization | Flag to manage customization. | `bool` | `false` |
| manage_events | Flag to manage events. | `bool` | `false` |
| manage_rbac | Flag to manage RBAC. | `bool` | `false` |
| manage_blueprints | Flag to manage blueprints. | `bool` | `false` |
| manage_endpoint_devices | Flag to manage endpoint devices. | `bool` | `false` |
| manage_tasks | Flag to manage tasks. | `bool` | `false` |
| write_default_values_file | Path to write all default values to a YAML file. | `string` | `""` |

## Outputs

| Name | Description |
|------|-------------|
| default_values | All default values. |
| model | Full model. |

## Data Model

```yaml
authentik:
  system:
    system_settings: { ... }
    brands: [ ... ]
    certificate_key_pairs: [ ... ]
    outposts: [ ... ]
    service_connections:
      docker: [ ... ]
      kubernetes: [ ... ]
    tokens: [ ... ]
  applications:
    applications: [ ... ]
    providers:
      oauth2: [ ... ]
      saml: [ ... ]
      proxy: [ ... ]
      ldap: [ ... ]
      radius: [ ... ]
      scim: [ ... ]
  directory:
    users: [ ... ]
    groups: [ ... ]
    sources:
      ldap: [ ... ]
      oauth: [ ... ]
      saml: [ ... ]
  flows_and_stages:
    flows: [ ... ]
    stages:
      identification: [ ... ]
      password: [ ... ]
      user_login: [ ... ]
    flow_stage_bindings: [ ... ]
  customization:
    policies:
      expression: [ ... ]
      password: [ ... ]
    property_mappings:
      provider_scope: [ ... ]
    policy_bindings: [ ... ]
  events:
    rules: [ ... ]
    transports: [ ... ]
  rbac:
    roles: [ ... ]
    permissions:
      role: [ ... ]
      user: [ ... ]
  blueprints: [ ... ]
  endpoint_devices:
    connector_agents: [ ... ]
    device_access_groups: [ ... ]
  tasks:
    schedules: [ ... ]
```

## Name-based references

Many cross-resource references accept either UUIDs or human-readable names/slugs.
The module resolves names by looking up existing Authentik objects via data
sources (and falls back to UUIDs that match the v4 pattern). Module-managed
resources of the same kind are also resolvable by name from anywhere in the
config.

| Field | Reference type | Resolution |
|-------|----------------|------------|
| `authorization_flow`, `invalidation_flow`, `authentication_flow`, `bind_flow`, `unbind_flow`, `enrollment_flow`, `pre_authentication_flow`, `recovery_flow`, `passwordless_flow`, `target_flow`, `configure_flow`, `flow_*` (brand) | Flow **slug** | `data "authentik_flow"` by slug |
| `signing_key`, `encryption_key`, `signing_kp`, `verification_kp`, `encryption_kp`, `certificate`, `web_certificate`, `tls_verification`, `tls_authentication` | Cert **name** | `data "authentik_certificate_key_pair"` by name |
| `property_mappings` (OAuth2) | Scope mapping **name** | `data "authentik_property_mapping_provider_scope"` |
| `property_mappings` (SAML) | SAML mapping **name** | `data "authentik_property_mapping_provider_saml"` |
| `property_mappings` (SCIM / Google Workspace / Microsoft Entra) | SCIM mapping **name** | `data "authentik_property_mapping_provider_scim"` |
| `property_mappings` (RAC) | RAC mapping **name** | `data "authentik_property_mapping_provider_rac"` |
| `property_mappings` (Radius) | Radius mapping **name** | `data "authentik_property_mapping_provider_radius"` |
| `property_mappings` (sources) | Source mapping **name** | `data "authentik_property_mapping_source_ldap"` (LDAP); other source types resolvable only when module-managed |
| `webhook_mapping_body`, `webhook_mapping_headers` (event transport) | Notification mapping **name** | Resolvable only when module-managed (no by-name data source upstream) |

Example:

```yaml
authentik:
  applications:
    providers:
      oauth2:
        - name: "grafana"
          client_id: "grafana"
          authorization_flow: "default-provider-authorization-implicit-consent"
          invalidation_flow:  "default-provider-invalidation-flow"
          signing_key: "authentik Self-signed Certificate"
          property_mappings:
            - "authentik default OAuth Mapping: OpenID 'openid'"
            - "authentik default OAuth Mapping: OpenID 'email'"
            - "authentik default OAuth Mapping: OpenID 'profile'"
```

## Secret injection

YAML files support the `!env` tag (provided by the
[`netascode/utils`](https://registry.terraform.io/providers/netascode/utils/latest)
provider) to inject secrets from environment variables. This avoids storing
secrets in plaintext YAML:

```yaml
authentik:
  system:
    certificate_key_pairs:
      - name: "wildcard"
        certificate_data: !env WILDCARD_CERT_PEM
        key_data:         !env WILDCARD_KEY_PEM
```

> **Note:** Bash `$(cat file.pem)` command substitution strips trailing
> newlines. Export with a literal newline (e.g.
> `export WILDCARD_CERT_PEM="$(cat cert.pem)"$'\n'`) or use a secret manager
> (Vault, CI secrets) that preserves them — otherwise the Authentik API
> stores the PEM with a trailing newline that the local env value lacks,
> causing perpetual drift.

## Known limitations & patterns

### `var.model` + plan-time-unknown values

The module avoids the `yamlencode → yaml_merge → yamldecode` round-trip when
only `var.model` is provided (no `yaml_files` / `yaml_directories`). This
prevents `var.model` values whose contents include `random_password.x.result`,
`data.foo.bar.id`, or other plan-time-unknown values from tainting the entire
decoded structure as dynamic.

**Partial fix only.** Terraform's `any`-typed variable handling propagates
deep-nested unknowns through field-access chains. If you put an unknown value
inside a nested list (e.g.
`var.model.authentik.applications.providers.oauth2[0].client_secret = random_password.x.result`),
Terraform may still mark sibling `for_each` keysets (`provider name`, etc.)
as unknown at plan time, producing
`Error: Invalid for_each argument`. This is a Terraform language limitation,
not a bug in this module.

**Recommended patterns:**

1. **Let Authentik generate secrets where possible.** OAuth2 `client_secret`,
   tokens, and similar fields are sensitive *and computed* — omit them on the
   input side and read the generated value from the module output.

   ```hcl
   model = {
     authentik = {
       applications = {
         providers = {
           oauth2 = [{
             name               = "grafana"
             client_id          = "grafana"
             # client_secret omitted → Authentik generates it
             authorization_flow = "default-provider-authorization-implicit-consent"
             invalidation_flow  = "default-provider-invalidation-flow"
           }]
         }
       }
     }
   }
   ```

2. **For caller-supplied secrets, wrap with `nonsensitive()` at the module
   boundary** if your for_each keys collide with sensitive sibling fields.
   This strips Terraform's sensitivity tracking just at the for_each level;
   keep the actual secret stored in a sensitive output / state.

3. **Mix YAML + secret env vars.** Define the static structure in YAML and
   use `!env` for secrets. The YAML path is statically typed and `!env`
   resolves to known strings at parse time, sidestepping `var.model`'s
   `any`-typed field-access limitation entirely.

### Sensitive fields and `for_each`

Provider modules (oauth2, radius, scim, microsoft_entra, google_workspace) and
source modules (ldap, oauth, plex, scim) are wired with a sensitive-safe
`for_each` pattern: the key set is built from non-sensitive names/slugs only,
and config values flow through a separate lookup map. This lets sensitive
fields (`client_secret`, `shared_secret`, `token`, `bind_password`,
`consumer_secret`, `plex_token`, `kubeconfig`, `key_data`) carry through to
the underlying resource without requiring callers to `nonsensitive()` the
whole object.

```hcl
# Before (would fail with sensitive value):
# for_each = { for p in local.providers_oauth2 : p.name => p }

# After (key set is non-sensitive; sensitive values flow via lookup map):
# for_each = toset([for p in local.providers_oauth2 : p.name])
# client_secret = local.oauth2_provider_map[each.key].client_secret
```

# terraform-authentik-iac-authentik
