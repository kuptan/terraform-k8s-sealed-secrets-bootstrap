## Requirements

| Name | Version |
|------|---------|
| kubernetes | >= 1.18.0 |

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | >= 1.18.0 |
| tls | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) |
| [kubernetes_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) |
| [kubernetes_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) |
| [tls_private_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) |
| [tls_self_signed_cert](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_chart\_value\_files | A list of values.yaml files to be added to the chart installation. | `list(string)` | `[]` | no |
| auto\_generate\_key\_cert | A flag to auto generate key/cert for sealed secrets | `bool` | `true` | no |
| chart\_repository | The sealed secrets chart repository | `string` | `"https://bitnami-labs.github.io/sealed-secrets"` | no |
| chart\_values\_overrides | A map of key/value to override the chart values. The key must be the path/name of the chart value, e.g: `path.to.chart.key` | `map(string)` | `{}` | no |
| chart\_version | The sealed secrets chart version | `string` | `"1.16.1"` | no |
| create\_namespace | Indicates whether to create a Kubernetes namespace or not | `bool` | `true` | no |
| key\_cert | The key/cert config for sealed secrets. If `auto_generate_key_cert` is false and no custom key/cert is provided, no custom key/cert will be generated | <pre>object({<br>    private_key : string<br>    private_cert : string<br>  })</pre> | <pre>{<br>  "private_cert": "",<br>  "private_key": ""<br>}</pre> | no |
| namespace | The namespace name where the sealed secret chart will be installed. If 'create\_namespace' is 'true', a Namespace with the provided value will be created, otherwise, it will assume the namespace with this name already exist | `string` | `"sealed-secrets"` | no |
| namespace\_labels | labels to be added to the namespace | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| generated\_cert | n/a |
| generated\_private\_key | n/a |
| namespace\_name | n/a |
