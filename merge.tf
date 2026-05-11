locals {
  yaml_strings_directories = flatten([
    for dir in var.yaml_directories : [
      for file in fileset(".", "${dir}/*.{yml,yaml}") : file(file)
    ]
  ])
  yaml_strings_files = [
    for file in var.yaml_files : file(file)
  ]
  # Short-circuit the yamlencode->yaml_merge->yamldecode round-trip when only
  # var.model is provided. Without this, any plan-time-unknown values inside
  # var.model (random_password.x.result, data source IDs, sensitive outputs)
  # taint the entire decoded structure as dynamic, breaking downstream
  # for_each enumeration of statically-known YAML fields.
  #
  # In model_only_mode, local.model_string is the empty string, so yamldecode
  # fails and try() falls back to var.model verbatim — preserving its native
  # type information. We avoid a plain ternary because Terraform requires both
  # branches to have consistent statically-inferable types, which doesn't hold
  # when var.model has a richer/different shape than the yamldecoded value.
  model_only_mode = length(var.yaml_directories) == 0 && length(var.yaml_files) == 0
  model_strings   = local.model_only_mode || length(keys(var.model)) == 0 ? [] : [yamlencode(var.model)]
  model_string    = local.model_only_mode ? "" : provider::utils::yaml_merge(concat(local.yaml_strings_directories, local.yaml_strings_files, local.model_strings))
  model           = try(yamldecode(local.model_string), var.model)

  # Defaults/modules merge: in model_only_mode, only use the static YAML files
  # (defaults.yaml / modules.yaml) and merge user overrides at the access site
  # via try(). Going through yamlencode(local.user_*) would taint local.modules
  # and local.defaults with any unknowns nested in var.model.
  defaults_string = local.model_only_mode ? file("${path.module}/defaults/defaults.yaml") : provider::utils::yaml_merge([file("${path.module}/defaults/defaults.yaml"), yamlencode({ "defaults" : try(local.model["defaults"], {}) })])
  defaults_yaml   = yamldecode(local.defaults_string)["defaults"]
  defaults        = local.model_only_mode ? merge(local.defaults_yaml, try(var.model.defaults, {})) : local.defaults_yaml

  modules_string  = local.model_only_mode ? file("${path.module}/defaults/modules.yaml") : provider::utils::yaml_merge([file("${path.module}/defaults/modules.yaml"), yamlencode({ "modules" : try(local.model["modules"], {}) })])
  modules_yaml    = yamldecode(local.modules_string)["modules"]
  modules         = local.model_only_mode ? merge(local.modules_yaml, try(var.model.modules, {})) : local.modules_yaml

  # Authentik section shortcuts
  system           = try(local.model.authentik.system, {})
  applications     = try(local.model.authentik.applications, {})
  directory        = try(local.model.authentik.directory, {})
  flows_and_stages = try(local.model.authentik.flows_and_stages, {})
  customization    = try(local.model.authentik.customization, {})
  events           = try(local.model.authentik.events, {})
  rbac             = try(local.model.authentik.rbac, {})
  blueprints_cfg   = try(local.model.authentik.blueprints, {})
  endpoint_devices = try(local.model.authentik.endpoint_devices, {})
  tasks            = try(local.model.authentik.tasks, {})
}

resource "terraform_data" "validation" {
  lifecycle {
    precondition {
      condition     = length(var.yaml_directories) != 0 || length(var.yaml_files) != 0 || length(keys(var.model)) != 0
      error_message = "Either `yaml_directories`,`yaml_files` or a non-empty `model` value must be provided."
    }
  }
}

resource "local_sensitive_file" "defaults" {
  count    = var.write_default_values_file != "" ? 1 : 0
  content  = local.defaults_string
  filename = var.write_default_values_file
}