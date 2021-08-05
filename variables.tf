variable "create_namespace" {
  description = "Indicates whether to create a Kubernetes namespace or not"
  type = bool

  default = true
}

variable "namespace" {
  description = "The namespace name where the sealed secret chart will be installed. If 'create_namespace' is 'true', a Namespace with the provided value will be created, otherwise, it will assume the namespace with this name already exist"
  type        = string

  default = "sealed-secrets"
}

variable "namespace_labels" {
  description = "labels to be added to the namespace"
  type        = map(string)

  default = {}
}

variable "auto_generate_key_cert" {
  description = "A flag to auto generate key/cert for sealed secrets"
  type        = bool

  default = true
}

variable "key_cert" {
  description = "The key/cert config for sealed secrets. If `auto_generate_key_cert` is false and no custom key/cert is provided, no custom key/cert will be generated"
  sensitive   = true
  type = object({
    private_key : string
    private_cert : string
  })

  default = {
    private_key  = ""
    private_cert = ""
  }
}

variable "chart_repository" {
  description = "The sealed secrets chart repository"
  type = string

  default = "https://bitnami-labs.github.io/sealed-secrets"
}

variable "chart_version" {
  description = "The sealed secrets chart version"
  type = string

  default = "1.16.1"
}


variable "additional_chart_value_files" {
  description = "A list of values.yaml files to be added to the chart installation."
  type        = list(string)

  default = []
}

variable "chart_values_overrides" {
  description = "A map of key/value to override the chart values. The key must be the path/name of the chart value, e.g: `path.to.chart.key`"
  type        = map(string)

  default = {}
}