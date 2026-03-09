variable "yaml_directories" {
  description = "List of paths to YAML directories."
  type        = list(string)
  default     = []
}

variable "yaml_files" {
  description = "List of paths to YAML files."
  type        = list(string)
  default     = []
}

variable "model" {
  description = "As an alternative to YAML files, a native Terraform data structure can be provided as well."
  type        = map(any)
  default     = {}
}

variable "manage_system" {
  description = "Flag to indicate if system settings should be managed."
  type        = bool
  default     = false
}

variable "manage_applications" {
  description = "Flag to indicate if applications should be managed."
  type        = bool
  default     = false
}

variable "manage_directory" {
  description = "Flag to indicate if directory (users, groups, sources) should be managed."
  type        = bool
  default     = false
}

variable "manage_flows_and_stages" {
  description = "Flag to indicate if flows and stages should be managed."
  type        = bool
  default     = false
}

variable "manage_customization" {
  description = "Flag to indicate if customization (policies, property mappings) should be managed."
  type        = bool
  default     = false
}

variable "manage_events" {
  description = "Flag to indicate if events should be managed."
  type        = bool
  default     = false
}

variable "manage_rbac" {
  description = "Flag to indicate if RBAC should be managed."
  type        = bool
  default     = false
}

variable "manage_blueprints" {
  description = "Flag to indicate if blueprints should be managed."
  type        = bool
  default     = false
}

variable "manage_endpoint_devices" {
  description = "Flag to indicate if endpoint devices should be managed."
  type        = bool
  default     = false
}

variable "manage_tasks" {
  description = "Flag to indicate if tasks should be managed."
  type        = bool
  default     = false
}

variable "write_default_values_file" {
  description = "Write all default values to a YAML file. Value is a path pointing to the file to be created."
  type        = string
  default     = ""
}