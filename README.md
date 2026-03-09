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
| model | Native Terraform data structure (alternative to YAML). | `map(any)` | `{}` |
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
# terraform-authentik-iac-authentik
